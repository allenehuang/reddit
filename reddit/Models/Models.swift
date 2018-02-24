//
//  Models.swift
//  reddit
//
//  Created by Allen Huang on 2/24/18.
//  Copyright © 2018 Allen Huang. All rights reserved.
//

import Foundation

struct TopResults: Codable {
    let kind: String
    let data: ResultsData
}

struct ResultsData: Codable {
    let after: String
    let dist: Int
    let modhash: String
    let whiteListStatus: String
    let children: [Post]

    enum CodingKeys: String, CodingKey {
        case after
        case dist
        case modhash
        case whiteListStatus = "whitelist_status"
        case children
    }
}

struct Post: Codable {
    let kind: String
    let data: PostData
}

struct PostData: Codable {
    let author: String
    let title: String
    let numberOfComments: Int
    let thumbnail: String?
    let dateCreated: Date
    var thumbnailURL: URL? {
        if let thumbnail = thumbnail {
            return URL(string: thumbnail)
        } else {
            return nil
        }
    }
    let url: String
    var convertedURL: URL? {
        return URL(string: url)
    }
    let type: String?
    let postID: String

    enum CodingKeys: String, CodingKey {
        case author
        case title
        case numberOfComments = "num_comments"
        case thumbnail
        case dateCreated = "created"
        case url
        case type = "post_hint"
        case postID = "name"
    }
}

