import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private var navigationController: UINavigationController?
    private var childCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
    }

    private func goToAbout() {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen

        let coordinator = MainCoordinator(navigationController: navigationController) { [weak self] in
            self?.navigationController?.dismiss(animated: true)
            self?.childCoordinator = nil
        }
        coordinator.start()

        childCoordinator = coordinator

        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }

    private func goToTodo() {
        guard let navigationController else {
            return
        }

        let coordinator = TodoCoordinator(navigationController: navigationController)
        coordinator.parent = self
        coordinator.start()

        childCoordinator = coordinator
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        let homeViewController = HomeViewController()
            .onTodoButtonClick { [weak self] in
                self?.goToTodo()
            }
            .onAboutButtonClick { [weak self] in
                self?.goToAbout()
            }

        let navigationController = UINavigationController()
        navigationController.viewControllers = [
            homeViewController
        ]

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.navigationController = navigationController
    }

    func removeChildCoordinator() {
        childCoordinator = nil
    }
}
