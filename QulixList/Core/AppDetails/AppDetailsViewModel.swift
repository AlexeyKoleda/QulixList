//
//  AppDetailsViewModel.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

class AppDetailsViewModel {
    
    var detailedAppModel: DetailedAppModel?
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadAppDetails(appId: String, completion: @escaping ((DetailedAppModel) -> Void)) {
        networkService.getAppDetails(for: appId, completion: { (appData, dataStatus) in
            guard let appData = appData else { return }
            let AppDetails = AppDetails(appId: appId, appData: appData)
            let detailedAppModel = DetailedAppModel(appID: appId, appDetails: AppDetails, dataStatus: dataStatus)
            self.detailedAppModel = detailedAppModel
            completion(detailedAppModel)
        })
    }
    
    
}
