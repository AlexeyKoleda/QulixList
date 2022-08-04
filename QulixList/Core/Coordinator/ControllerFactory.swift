//
//  Coordinator.swift
//  QulixList
//
//  Created by Alexey Koleda on 04.08.2022.
//

import UIKit

protocol ControllerFactory {
    func makeAppList(showAppDetailsScreen: @escaping (AppModel) -> Void) -> UIViewController
    func makeAppDetails(app: AppModel) -> UIViewController
}

final class ControllerFactoryImplementation: ControllerFactory {

    func makeAppList(showAppDetailsScreen: @escaping (AppModel) -> Void) -> UIViewController {
        let networkService = NetworkServiceImplementation()
        let viewModel = AppListViewModel(networkService: networkService)
        let viewController = AppListViewController(viewModel: viewModel, goToDetails: showAppDetailsScreen)
        viewController.navigationItem.title = "Games"
        return viewController
    }
    
    func makeAppDetails(app: AppModel) -> UIViewController {
        let networkService = NetworkServiceImplementation()
        let viewModel = AppDetailsViewModel(networkService: networkService)
        let viewController = AppDetailsViewController(viewModel: viewModel)
        viewController.title = app.name
        viewController.appId = String(app.appId)
        return viewController
    }
}
