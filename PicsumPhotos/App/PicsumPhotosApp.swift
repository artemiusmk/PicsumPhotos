//
//  PicsumPhotosApp.swift
//  PicsumPhotos
//
//  Created by Artemiusmk on 3/4/21.
//

import SwiftUI

@main
struct PicsumPhotosApp: App {
    
    let store = AppStore(initialState: .init(dashboard: DashboardState(), details: DetailsState()),
                         reducer: appReducer,
                         middlewares: [dashboardMiddleware(photoService: PhotoService(network: Network()))])
    
    init() {
        store.dispatch(.dashboard(action: .fetchPhotos))
    }
    
    var body: some Scene {
        WindowGroup {
            DashboardView().environmentObject(store)
        }
    }
}
