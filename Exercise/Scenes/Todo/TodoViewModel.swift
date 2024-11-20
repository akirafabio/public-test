import Foundation

protocol TodoViewModelInterface {
    var items: [String] { get }
    func backButtonDidTouch()
    func saveTask(taskName: String)
}

final class TodoViewModel {
    var items: [String] {
        didSet {

        }
    }

    private var onBackButtonAction: (() -> Void)?

    init(items: [String] = []) {
        self.items = items
    }

    @discardableResult
    func onBackButtonTouch(_ onBackButtonAction: @escaping () -> Void) -> Self {
        self.onBackButtonAction = onBackButtonAction
        return self
    }
}

extension TodoViewModel: TodoViewModelInterface {
    func backButtonDidTouch() {
        onBackButtonAction?()
    }

    func saveTask(taskName: String) {
        items.append(taskName)
    }
}
