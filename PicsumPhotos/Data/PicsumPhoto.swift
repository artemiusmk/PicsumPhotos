//
//  PicsumPhoto.swift
//  PicsumPhotos
//
//  Created by Artem.Makhovyk on 4/1/21.
//

import Foundation

struct PicsumPhoto: Codable, Identifiable, Equatable {
    let id: String
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let downloadUrl: URL?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case downloadUrl = "download_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        downloadUrl = try values.decodeIfPresent(String.self, forKey: .downloadUrl).flatMap(URL.init)
    }
    
    var displayUrl: URL? {
        downloadUrl?.deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("300")
            .appendingPathComponent("200")
    }

}
