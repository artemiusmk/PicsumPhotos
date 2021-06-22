//
//  DetailsView.swift
//  PicsumPhotos
//
//  Created by Artem.Makhovyk on 6/22/21.
//

import SwiftUI
import Kingfisher

struct PhotoInfo: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        KFImage(store.state.details.data?.displayUrl)
            .resizable()
            .blur(radius: 20.0)
            .overlay(
                KFImage(store.state.details.data?.downloadUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
            .ignoresSafeArea()
            .onTapGesture {
                close()
            }
    }
}

extension PhotoInfo {

    func close() {
        store.dispatch(.details(action: .close))
    }

}
