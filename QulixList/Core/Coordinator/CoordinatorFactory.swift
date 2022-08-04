//
//  CoordinatorFactory.swift
//  QulixList
//
//  Created by Alexey Koleda on 04.08.2022.
//

import UIKit

final class CoordinatorFactory {
    
    private let configureWindow: () -> Void
    
    init(configureWindow: @escaping () -> Void) {
        self.configureWindow = configureWindow
    }
    
    func makeCoordinator(navigation: UINavigationController) -> Coordinator {
        let factory = ControllerFactoryImplementation()
        let coordinator = MainCoordinator(navigationController: navigation, factory: factory)
        return coordinator
    }
}
