//
//  AppDetailsModel.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

struct AppDetailsResponceModel: Decodable {
    let appDetails: AppDetailsResult?

    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var details: AppDetailsResult?

        for key in container.allKeys {
            details = try container.decode(AppDetailsResult.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
        }

        if let details = details {
            appDetails = details
        } else {
            appDetails = nil
        }
    }
}

struct AppDetailsResult: Decodable {
    let success: Bool
    let data: AppData
}

struct AppData: Decodable {
    let name: String
    let shortDescription: String
    let headerImageURLString: String?
    let genres: [GenreItem]?
    let platforms: Platforms
    let releaseDate: ReleaseDate
    let screenshots: [Screenshot]?
    let priceItem: PriceItem?

    enum CodingKeys: String, CodingKey {
        case name, platforms, genres, screenshots
        case shortDescription = "short_description"
        case headerImageURLString = "header_image"
        case releaseDate = "release_date"
        case priceItem = "price_overview"
      }
}

struct Platforms: Decodable {
    let windows: Bool
    let mac: Bool
    let linux: Bool
}

struct GenreItem: Decodable {
    let identifier: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case description
        case identifier = "id"
    }
}

struct ReleaseDate: Decodable {
    let isComingSoon: Bool
    let date: String

    enum CodingKeys: String, CodingKey {
        case date
        case isComingSoon = "coming_soon"
    }
}

struct Screenshot: Decodable {
    let identifier: Int
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imagePath = "path_thumbnail"
    }
}

struct PriceItem: Decodable {
    let discountPercent: Int
    let priceTitle: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case discountPercent = "discount_percent"
        case priceTitle = "final_formatted"
        case price = "final"
    }
}

