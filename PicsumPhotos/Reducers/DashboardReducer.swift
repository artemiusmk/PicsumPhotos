//
//  DashboardReducer.swift
//  PicsumPhotos
//

import Foundation

func dashboardReducer(state: inout AppState, action: DashboardAction) -> Void {

    switch action {
    
    case .openDetails(let id):
        state.details.data = state.dashboard.items.first {
            $0.id == id
        }
        
    case .fetchPhotos:
        state.dashboard.loadingPageCount += 1
        
    case .fetchCompleted(let data):
        state.dashboard.loadingPageCount = 0
        
        guard let data = data else { return }
        state.dashboard.items += data.data
        state.dashboard.loadedPagesCount = data.page

    default:
        break
    }
}
