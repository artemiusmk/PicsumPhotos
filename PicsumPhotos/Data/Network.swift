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
    func download<T: Decodable>(path: String, queryItems: [URLQueryItem]) -> AnyPublisher<T, Error>
}

public final class Network: Networking {
    
    private let baseUrl = "https://picsum.photos/v2/"
    
    private func urlWithPath(_ path: String, queryItems: [URLQueryItem]) -> URL {
        
        var components = URLComponents(string: baseUrl + path)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            fatalError("Invalid path url \(path)")
        }
        return url
    }
    
    func download<T: Decodable>(path: String, queryItems: [URLQueryItem]) -> AnyPublisher<T, Error> {
        let url = urlWithPath(path, queryItems: queryItems)
        let publisher = AF.request(url).publishDecodable(type: T.self)
        return publisher.value().mapError { $0 as Error }.eraseToAnyPublisher()
    }
}

extension Network: PhotoFetching {
    
    // https://picsum.photos/v2/list?page=2&limit=100
    func photos(page: Int) -> AnyPublisher<PhotoPage, Error> {
        let publisher: AnyPublisher<[PicsumPhoto], Error> = download(path: "list", queryItems: [.init(name: "page", value: page.description)])
        return publisher.map {
            PhotoPage(page: page, data: $0)
        }.eraseToAnyPublisher()
    }
}
