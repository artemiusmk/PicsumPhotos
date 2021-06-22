//
//  DashboardAction.swift
//  PicsumPhotos
//
//  Created by Daniel Bernal on 8/12/20.
//

import SwiftUI

enum DashboardAction {
    case fetchPhotos
    case fetchCompleted(PhotoPage?)
    case openDetails(id: String)
}
