import UIKit

final class TodoCoordinator {
    weak var parent: Coordinator?

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private func close() {
        navigationController.popViewController(animated: true)
        parent?.removeFromParent()
    }
}

extension TodoCoordinator: Coordinator {
    func start() {
        let service = TodoService()

        let viewModel = TodoViewModel(service: service)

        viewModel.onBackButtonTouch { [weak self] in
            self?.close()
        }

        let viewController = TodoViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }
}
