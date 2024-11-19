import UIKit

final class MainCoordinator {
    let navigationController: UINavigationController

    let onFinish: (() -> Void)?

	init(navigationController: UINavigationController, onFinish: (() -> Void)? = nil) {
        self.navigationController = navigationController
        self.onFinish = onFinish
	}

    private func close() {
        onFinish?()
    }
}

extension MainCoordinator: Coordinator {
    func start() {
        let viewController = AboutViewController()
        viewController.onClose = { [weak self] in
            self?.close()
        }
        navigationController.pushViewController(viewController, animated: false)
    }
}
