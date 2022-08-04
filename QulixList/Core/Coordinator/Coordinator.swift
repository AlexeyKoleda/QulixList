//
//  Coordinator.swift
//  QulixList
//
//  Created by Alexey Koleda on 04.08.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

final class MainCoordinator: Coordinator {
    
    private let factory: ControllerFactory
    private let navigationController: UINavigationController
    
    init(
        navigationController: UINavigationController,
        factory: ControllerFactory
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let vc = factory.makeAppList(showAppDetailsScreen: moveToDetails)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func moveToDetails(app: AppModel) {
        let vc = factory.makeAppDetails(app: app)
        navigationController.pushViewController(vc, animated: true)
    }
}
