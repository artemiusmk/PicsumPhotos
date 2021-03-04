//
//  DashboardView.swift
//  PicsumPhotos
//
//  Created by Artemiusmk on 3/4/21.
//

import SwiftUI
import Kingfisher

struct DashboardView: View {
    
    var viewModel = DashboardViewModel()
    
    var body: some View {
        List(viewModel.items) {
            KFImage($0.displayUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
