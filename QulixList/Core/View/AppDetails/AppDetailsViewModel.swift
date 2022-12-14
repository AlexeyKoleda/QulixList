//
//  AppDetailsViewModel.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

final class AppDetailsViewModel {
    
    var detailedAppModel: DetailedAppModel?
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadAppDetails(appId: String, completion: @escaping ((DetailedAppModel) -> Void)) {
        networkService.getAppDetails(for: appId, completion: { [weak self] (appData, dataStatus) in
            guard let appData = appData else { return }
            let AppDetails = AppDetails(appId: appId, appData: appData)
            let detailedAppModel = DetailedAppModel(appID: appId, appDetails: AppDetails, dataStatus: dataStatus)
            self?.detailedAppModel = detailedAppModel
            completion(detailedAppModel)
        })
    }

    func loadImage(from url: String, completion: @escaping (Data) -> Void) {
        networkService.downloadImage(url: url) { data in
            completion(data)
        }
    }
}
