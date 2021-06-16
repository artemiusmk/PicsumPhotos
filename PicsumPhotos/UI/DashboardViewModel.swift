//
//  DashboardViewModel.swift
//  PicsumPhotos
//
//  Created by Artemiusmk on 3/4/21.
//

import Foundation
import Combine


class DashboardViewModel: ObservableObject {
    
    @Published var items: [PicsumPhoto] = []
    var loadedPagesCount = 0
    
    let service = PhotoService(network: Network())
    
    var cancellation: AnyCancellable?
    
    init() {
        fetchPhotos()
    }
    
    func fetchPhotos() {
        guard cancellation == nil else { return }
        cancellation = service.photos(page: loadedPagesCount + 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                self?.photosLoaded($0)
            })
    }
    
    private func photosLoaded(_ photoPage: PhotoPage) {
        cancellation = nil
        items += photoPage.data
        loadedPagesCount = photoPage.page
    }
}
