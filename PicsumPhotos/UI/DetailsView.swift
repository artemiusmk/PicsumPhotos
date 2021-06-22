//
//  DetailsView.swift
//  PicsumPhotos
//
//  Created by Artem.Makhovyk on 6/22/21.
//

import SwiftUI
import Kingfisher

struct PhotoInfo: View {
    
    @Binding var selectedId: String?
    
    let photo: PicsumPhoto
    
    var body: some View {
        KFImage(photo.displayUrl)
            .resizable()
            .blur(radius: 20.0)
            .overlay(
                KFImage(photo.downloadUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
            .ignoresSafeArea()
            .onTapGesture {
                selectedId = nil
            }
    }
}
