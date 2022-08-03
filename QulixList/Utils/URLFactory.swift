//
//  URLFactory.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

final class URLFactory {
    
    private static func makeURL(sheme: String = "https", host: String, path: String, queryItems: [URLQueryItem] = []) -> URL {
        var components = URLComponents()
        components.scheme = sheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Failed to construct URL")
        }
        return url
    }
    
    static func makeAppListURL() -> URL {
        return makeURL(host: "api.steampowered.com", path: "/ISteamApps/GetAppList/v2/")
    }

}
