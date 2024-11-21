import UIKit

enum AlertViewControllerFactory {
    static func todoAlert(onPrimaryAction: ((String?) -> Void)? = nil) -> UIAlertController {
        let alertViewController = UIAlertController(
            title: Strings.TodoAlert.title,
            message: nil,
            preferredStyle: .alert
        )

        alertViewController.addTextField { textField in
            textField.placeholder = Strings.TodoAlert.textfieldPlaceholder
        }

        let cancelAction = UIAlertAction(
            title: Strings.TodoAlert.cancelButtonTitle,
            style: .cancel
        )
        alertViewController.addAction(cancelAction)

        let primaryAction = UIAlertAction(
            title: Strings.TodoAlert.primaryButtonTitle,
            style: .default
        ) { _ in
            guard let textFields = alertViewController.textFields else {
                onPrimaryAction?(nil)
                return
            }
            guard let textField = textFields[safe: 0] else {
                onPrimaryAction?(nil)
                return
            }
            onPrimaryAction?(textField.text)
        }
        alertViewController.addAction(primaryAction)

        return alertViewController
    }
}
