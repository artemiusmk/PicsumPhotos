//
//  DashboardMiddleware.swift
//  PicsumPhotos
//

import Foundation
import Combine

func dashboardMiddleware(photoService: PhotoService) -> Middleware<AppState, AppAction> {
    
    return { state, action in
        switch action {
        
        case .dashboard(action: .fetchPhotos):
            guard state.dashboard.loadingPageCount == 1 else {
                return Empty().eraseToAnyPublisher()
            }
            return photoService.photos(page: state.dashboard.loadedPagesCount + 1)
                .map { AppAction.dashboard(action: .fetchCompleted($0)) }
                .catch { _ in
                        Just(AppAction.dashboard(action: .fetchCompleted(nil)))
                }
                .eraseToAnyPublisher()
            
        default:
            break
        }
        return Empty().eraseToAnyPublisher()
    }
    
}
