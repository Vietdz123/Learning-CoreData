//
//  WDNetworkModel.swift
//  WallPaper
//
//  Created by MAC on 26/10/2023.
//

import SwiftUI


import SwiftUI

struct EztWidgetResponse: Codable {
    let data: WidgetData
}

struct WidgetData: Codable {
    let data: [EztWidget]
}

struct EztWidget: Codable {
    let id: Int
    let thumbnail: [Thumbnail]
    let sound: [WidgetSound]?
    let path: [WidgetPath]
    let category_id: Int
    let is_trend: Int
    let is_private: Int
    let order: Int
    let active: Int
    let download: Int
    let rating: Int
    let daily_rating: Int
    let set: Int
    let cost: Int
    let license: String
    let updated_at: String
    let created_at: String
    let category: CategoryWidget
    let apps: [EztApp]
    let tags: [EzTags]
}

struct Thumbnail: Codable {
    let file_name: String
    let key_type: String
    let type_file: String
    let url: PathURL
}

struct WidgetSound: Codable {
    let file_name: String
    let key_type: String
    let type_file: String
    let url: PathURL
}

struct WidgetPath: Codable {
    let file_name: String
    let key_type: String
    let type_file: String
    let url: PathURL
}

struct PathURL: Codable {
    let full: String
    let preview: String
    let small: String
    let extra_small: String
}

struct CategoryWidget: Codable {
    let id: Int
    let name: String
}

struct EztApp: Codable {
    let id: Int
    let name: String
   
}

struct EzTags: Codable {
    let id: Int
    let name: String
    let laravel_through_key: Int
}
