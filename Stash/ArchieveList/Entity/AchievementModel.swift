//
//  AchievementModel.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import Foundation

struct AchievementWrapper : Codable {
    var success: Bool
    var status: Int
    var overview: AchievementOverview?
    var achievements: [AchievementModel]?

    enum CodingKeys: String, CodingKey {
        case success
        case status
        case overview
        case achievements
    }
}

struct AchievementOverview : Codable {
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case title
    }
}

struct AchievementModel : Codable {
    let id: Int
    let level: String
    let progress: Int
    let total: Int
    let bgImageUrl: String?
    let accessible: Bool

    enum CodingKeys: String, CodingKey {
        case id, level, progress, total
        case bgImageUrl = "bg_image_url"
        case accessible
    }
}
