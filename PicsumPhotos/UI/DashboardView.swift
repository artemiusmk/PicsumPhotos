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
    
    @State private var selectedId: String?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.items) { item in
                    KFImage(item.displayUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8.0)
                        .overlay(
                            ImageOverlay(author: item.author),
                            alignment: .bottomLeading
                        )
                        .frame(height: UIScreen.main.bounds.size.width * CGFloat(0.6))
                        .onAppear {
                            if item == viewModel.items.last {
                                viewModel.fetchPhotos()
                            }
                        }
                        .popover(isPresented: selectedItem(item)) {
                            PhotoInfo(selectedId: $selectedId, photo: item)
                        }
                        .onTapGesture {
                            selectedId = item.id
                        }
                }
            }
        }
    }
    
    func selectedItem(_ item: PicsumPhoto) -> Binding<Bool> {
        .init(get: {
            selectedId == item.id
        }, set: { _ in })
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


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
