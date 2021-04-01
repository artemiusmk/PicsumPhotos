//
//  PhotoService.swift
//  PicsumPhotos
//
//  Created by Artem.Makhovyk on 3/27/21.
//

import Foundation
import Combine

protocol PhotoFetching {
    func photos() -> AnyPublisher<[PicsumPhoto], Error>
}

struct PhotoService {
    
    let network: PhotoFetching
    
    func photos() -> AnyPublisher<[PicsumPhoto], Error> {
        network.photos()
    }
}
