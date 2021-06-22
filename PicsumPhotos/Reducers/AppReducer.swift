//
//  AppReducer.swift
//  PicsumPhotos
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch(action) {

    case .details(let action):
        detailsReducer(state: &state.details, action: action)

    case .dashboard(let action):
        dashboardReducer(state: &state, action: action)
        
    }
}
