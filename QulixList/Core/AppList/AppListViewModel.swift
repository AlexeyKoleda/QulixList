//
//  AppListViewModel.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

class AppListViewModel {
    var appList = [AppModel]()
    var filteredAppList = [AppModel]()
    
    func loadAppList(_ completion: @escaping ([AppModel], DataStatus) -> Void) {
        NetworkService.getAppList() { [weak self] (appList, dataStatus) in
            self?.appList = appList
            self?.filteredAppList = appList
            completion(appList, dataStatus)
        }
    }
    
    func filterAppList(searchText: String) {
        if searchText.isEmpty {
            filteredAppList = appList
        } else {
            filteredAppList = appList.filter {
                $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
}
