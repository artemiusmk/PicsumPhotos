//
//  DetailsReducer.swift
//  PicsumPhotos
//

import Foundation

func detailsReducer(state: inout DetailsState, action: DetailsAction) -> Void {
    switch action {

    case .close:
        state.data = nil
        
    default:
        break
    }

}
