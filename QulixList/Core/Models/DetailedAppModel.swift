//
//  DetailedAppModel.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

struct DetailedAppModel {
    var dataStatus: DataStatus
    var appDetails: AppDetails?

    init(appID: String, appDetails: AppDetails?, dataStatus: DataStatus) {
        self.dataStatus = dataStatus
        self.appDetails = appDetails
    }
}

struct AppDetails {
    var appId: String = ""
    var name: String = ""
    var shortDescription: String = ""
    var headerImageURLString: String?
    var isApple: Bool = false
    var isWindows: Bool = false
    var isLinux: Bool = false
    var isComingSoon: Bool = false
    var isFavorite: Bool = false
    var releaseDate: Date?
    var isFree: Bool = false
    var priceTitle: String?
    var price: Float?
    var discont: Int?
    var genres: [String]?
    var screenshotsURLs: [String]?

    init?(appId: String, appData: AppData) {
        self.appId = appId
        self.name = appData.name
        self.shortDescription = appData.shortDescription
        self.headerImageURLString = appData.headerImageURLString
        self.isApple = appData.platforms.mac
        self.isLinux = appData.platforms.linux
        self.isWindows = appData.platforms.windows
        self.isComingSoon = appData.releaseDate.isComingSoon
        self.isFavorite = false
        if let priceItem = appData.priceItem {
            self.isFree = false
            self.price = Float(priceItem.price) / 100
            self.priceTitle = priceItem.priceTitle
            self.discont = priceItem.discountPercent
        } else {
            self.isFree = true
        }
        if !appData.releaseDate.isComingSoon {
            self.releaseDate = CustomDateFormater.shared.getDate(from: appData.releaseDate.date)
        }
        if let genres = appData.genres {
            self.genres = [String]()
            for genre in genres {
                self.genres?.append(genre.description)
            }
        }
    }
}
