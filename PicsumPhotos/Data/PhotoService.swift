//
//  PhotoService.swift
//  PicsumPhotos
//
//  Created by Artem.Makhovyk on 3/27/21.
//

import Foundation
import Combine

struct PhotoPage: Codable {
    let page: Int
    let data: [PicsumPhoto]
}

protocol PhotoFetching {
    func photos(page: Int) -> AnyPublisher<PhotoPage, Error>
}

struct PhotoService {
    
    let network: PhotoFetching
    
    func photos(page: Int) -> AnyPublisher<PhotoPage, Error> {
        network.photos(page: page)
    }
}
