//
//  DateFormatterService.swift
//  reddit
//
//  Created by Allen Huang on 2/24/18.
//  Copyright © 2018 Allen Huang. All rights reserved.
//

import Foundation

class DateFormatterService {
    static let shared = DateFormatterService()
    private let dateComponentsFormatter = DateComponentsFormatter()

    func getDifferenceInHours(date: Date) -> String {
        let timeInterval = NSInteger(Date().timeIntervalSince(date))
        let hours = timeInterval / 3600
        return hours == 1 ? "\(hours) hour ago" : "\(hours) hours ago"
    }
}
