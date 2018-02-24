//
//  SearchService.swift
//  reddit
//
//  Created by Allen Huang on 2/24/18.
//  Copyright © 2018 Allen Huang. All rights reserved.
//

import Foundation

class SearchService {
    static let shared = SearchService()

    private let host = "reddit.com"
    private let scheme = "https"

    func getTopPosts(completion: @escaping ([Post]?, Error?) -> ()) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/top.json"

        URLSession.shared.dataTask(with: components.url!) { data, response, error in
            if let data = data {
//                                let jsonRepresentation = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//                                print(jsonRepresentation)
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let results = try decoder.decode(TopResults.self, from: data)
                    completion(results.data.children, nil)

                } catch let error as NSError {
                    completion(nil, error)
                }
            }
            }.resume()
    }
}
