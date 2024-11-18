//
//  AppCoordinator.swift
//  Exercise
//

import UIKit

class AppCoordinator {
    private let window: UIWindow

    private var childCoordinator: MainCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewController = ViewController()
        viewController.onAbout = { [weak self] in
            self?.goToAbout()
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    func goToAbout() {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen

        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.start()

        childCoordinator = coordinator


        window.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
}
