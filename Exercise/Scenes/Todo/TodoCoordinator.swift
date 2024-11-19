import UIKit

final class TodoCoordinator {
    weak var parent: Coordinator?

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private func close() {
        navigationController.popViewController(animated: true)
        parent?.removeChildCoordinator()
    }

    private func goToAdd() {
        print("[TEST] \(Self.self) \(#function)")
    }
}

extension TodoCoordinator: Coordinator {
    func start() {
        let viewController = TodoViewController()
            .onBackButtonClick { [weak self] in
                self?.close()
            }
            .onAddButtonClick { [weak self] in
                self?.goToAdd()
            }

        navigationController.pushViewController(viewController, animated: true)
    }
}
