//
//  DashboardView.swift
//  PicsumPhotos
//
//  Created by Artemiusmk on 3/4/21.
//

import SwiftUI
import Kingfisher

struct DashboardView: View {
    
    @ObservedObject var viewModel = DashboardViewModel()
    
    var body: some View {
        List(viewModel.items) { item in
            KFImage(item.displayUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8.0)
                .overlay(
                    ImageOverlay(author: item.author),
                    alignment: .bottomLeading
                )
                .onAppear {
                    if item == viewModel.items.last {
                        viewModel.fetchPhotos()
                    }
                }
        }
    }
}

struct ImageOverlay: View {
    
    let author: String?
    
    var body: some View {
        ZStack {
            Text(author ?? "")
                .font(.callout)
                .padding([.top, .bottom], 6.0)
                .padding([.leading, .trailing], 12.0)
                .foregroundColor(.white)
        }.background(Color.black)
        .opacity(0.7)
        .cornerRadius(16.0)
        .padding(10)
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
