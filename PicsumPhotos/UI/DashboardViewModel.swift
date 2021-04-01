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
    
    let service = PhotoService(network: Network())
    
    var cancellation: AnyCancellable?
    
    init() {
        fetchHeroes()
    }
    
    func fetchHeroes() {
        cancellation = service.photos()
            .sink(receiveCompletion: { _ in }, receiveValue: { items in
                self.items = items
            })
    }
}
