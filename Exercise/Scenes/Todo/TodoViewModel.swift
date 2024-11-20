import Foundation

protocol TodoViewModelInterface {
    var items: [TodoTask] { get }
    func updateView(_ onUpdateView: @escaping () -> Void)
    func backButtonDidTouch()
    func saveTask(_ task: TodoTask)
}

final class TodoViewModel {
    var items: [TodoTask] = []

    private var onBackButtonAction: (() -> Void)?
    private var onUpdateView: (() -> Void)?

    private let service: TodoServiceProtocol

    init(service: TodoServiceProtocol) {
        self.service = service
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

    func saveTask(_ task: TodoTask) {
        items.insert(task, at: 0)
        onUpdateView?()
//        service.saveTask(task: taskName) { isSaved in
//            print("- isSaved: \(isSaved)")
//        }
    }

    func updateView(_ onUpdateView: @escaping () -> Void) {
        self.onUpdateView = onUpdateView
    }
}
