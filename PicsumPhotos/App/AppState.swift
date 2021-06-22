//
//  AppState.swift
//  PicsumPhotos
//

import Foundation
import Combine

// MARK: App State
struct AppState {
    var dashboard: DashboardState
    var details: DetailsState
}

struct DetailsState {
    var data: PicsumPhoto?
}

struct DashboardState {
    var items: [PicsumPhoto] = []
    var loadedPagesCount = 0
    var loadingPageCount = 0
}
