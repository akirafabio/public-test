import UIKit

enum AlertViewControllerFactory {
    static func todoAlert(onPrimaryAction: ((String?) -> Void)? = nil) -> UIAlertController {
        let alertViewController = UIAlertController(
            title: "TO-DO",
            message: nil,
            preferredStyle: .alert
        )

        alertViewController.addTextField { textField in
            textField.placeholder = "Enter Task"
        }

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        alertViewController.addAction(cancelAction)

        let primaryAction = UIAlertAction(
            title: "Save",
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
