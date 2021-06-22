//
//  DashboardView.swift
//  PicsumPhotos
//
//  Created by Artemiusmk on 3/4/21.
//

import SwiftUI
import Kingfisher

struct DashboardView: View {
    
    @EnvironmentObject var store: AppStore
    
//    @ObservedObject private var viewModel = DashboardViewModel()
//
//    @State private var selectedId: String?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(store.state.dashboard.items) { item in
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
                            if item == store.state.dashboard.items.last {
                                fetchPhotos()
                            }
                        }
                        .popover(isPresented: isPresented()) {
                            PhotoInfo()
                        }
                        .onTapGesture {
                            openDetails(id: item.id)
                        }
                }
            }
        }
    }
    
    func isPresented() -> Binding<Bool> {
        .init(get: {
            store.state.details.data != nil
        }, set: { _ in })
    }
    
}

extension DashboardView {
    
    func fetchPhotos() {
        store.dispatch(.dashboard(action: .fetchPhotos))
    }

    func openDetails(id: String) {
        store.dispatch(.dashboard(action: .openDetails(id: id)))
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
