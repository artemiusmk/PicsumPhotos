//
//  Network.swift
//  PicsumPhotos
//
//  Created by Artem.Makhovyk on 3/27/21.
//

import Foundation
import Alamofire
import Combine

protocol Networking {
    func download<T: Decodable>(path: String) -> AnyPublisher<T, Error>
}

public final class Network: Networking {
    
    private let baseUrl = "https://picsum.photos/v2/"
    
    private func urlWithPath(_ path: String) -> URL {
        guard let url = URL(string: baseUrl + path) else {
            fatalError("Invalid path url \(path)")
        }
        return url
    }
    
    func download<T: Decodable>(path: String) -> AnyPublisher<T, Error> {
        let url = urlWithPath(path)
        let publisher = AF.request(url).publishDecodable(type: T.self)
        return publisher.value().mapError { $0 as Error }.eraseToAnyPublisher()
    }
}

extension Network: PhotoFetching {
    
    // https://picsum.photos/v2/list?page=2&limit=100
    func photos() -> AnyPublisher<[PicsumPhoto], Error> {
        download(path: "list")
    }
}
