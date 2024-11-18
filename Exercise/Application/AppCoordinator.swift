//
//  AppCoordinator.swift
//  Exercise
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    private var childCoordinator: MainCoordinator?

    private weak var viewController: UIViewController?

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

        self.viewController = viewController
    }

    func goToAbout() {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen

        let coordinator = MainCoordinator(navigationController: navigationController) { [weak self] in
            self?.viewController?.dismiss(animated: true)
            self?.childCoordinator = nil
        }

        coordinator.start()

        childCoordinator = coordinator

        viewController?.present(navigationController, animated: true, completion: nil)
    }
}
