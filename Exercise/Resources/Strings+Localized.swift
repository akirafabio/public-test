import Foundation

enum Strings {
    enum Home {
        /// About
        static let aboutButtonTitle = String(localized: "Home.aboutButtonTitle")
        /// TO-DO: 0
        static let todoButtonTitle = String(localized: "Home.todoButtonTitle")
    }

    enum About {
        /// About
        static let title = String(localized: "About.title")
        /// Public is where serious investors build their wealth. Grow your cash with higher yields and build a multi-asset portfolio for the long haul.
        static let label = String(localized: "About.label")
    }

    enum Todo {
        /// X
        static let deleteSwipeActionTitle = String(localized: "Todo.DeleteSwipeAction.title")
    }

    enum TodoAlert {
        /// Enter Task
        static let textfieldPlaceholder = String(localized: "TodoAlert.Textfield.placeholder")
        /// Cancel
        static let cancelButtonTitle = String(localized: "TodoAlert.CancelButton.title")
        /// Save
        static let primaryButtonTitle = String(localized: "TodoAlert.PrimaryButton.title")
        /// TO-DO
        static let title = String(localized: "TodoAlert.title")
    }
}
