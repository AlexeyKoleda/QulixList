//
//  AppListModel.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

struct AppListRequest: Decodable {
    let appList: AppListModel
    
    enum CodingKeys: String, CodingKey {
        case appList = "applist"
    }
}

struct AppListModel: Decodable {
    let apps: [AppModel]
}

struct AppModel: Decodable  {
    var appId: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case appId = "appid"
        case name
    }
}
