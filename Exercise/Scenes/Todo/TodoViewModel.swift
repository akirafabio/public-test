import Foundation
import Dispatch

protocol TodoViewModelInterface {
    var tasks: [TodoTask] { get }

    func backButtonDidTouch()
    func saveTask(_ taskName: String)

    func onUpdateView(_ updateView: @escaping () -> Void)
    func onDeleteTableCell(_ deleteTableCell: @escaping (IndexPath) -> Void)
    func onReloadTableCell(_ reloadRowsBinding: @escaping (IndexPath) -> Void)
}

final class TodoViewModel {
    private let taskQueue = DispatchQueue(label: "com.public.concurrent.queue", attributes: .concurrent)

    private(set) var tasks: [TodoTask] = []

    private var onBackButtonAction: (() -> Void)?

    private var updateViewBinding: (() -> Void)?
    private var deleteTableCellBinding: ((IndexPath) -> Void)?
    private var reloadTableCellBinding: ((IndexPath) -> Void)?

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

    func saveTask(_ taskName: String) {
        let task = TodoTask(name: taskName)

        tasks.insert(task, at: 0)
        updateViewBinding?()

        service.save(task) { [weak self] isTaskSaved in
            guard let self else {
                return
            }

            self.taskQueue.async(flags: .barrier) {
                guard let index = self.tasks.firstIndex(where: { $0.id == task.id }) else {
                    return
                }

                self.tasks[index].isSaving = false
                self.tasks[index].didFail = !isTaskSaved

                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: index, section: 0)
                    self.reloadTableCellBinding?(indexPath)
                }

                if isTaskSaved {
                    return
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.taskQueue.async(flags: .barrier) {
                        guard let indexToRemove = self.tasks.firstIndex(where: { $0.id == task.id })  else {
                            return
                        }
                        self.tasks.remove(at: indexToRemove)
                        DispatchQueue.main.async {
                            let indexPath = IndexPath(row: indexToRemove, section: 0)
                            self.deleteTableCellBinding?(indexPath)
                        }
                    }
                }
            }
        }
    }

    func onUpdateView(_ updateViewBinding: @escaping () -> Void) {
        self.updateViewBinding = updateViewBinding
    }

    func onDeleteTableCell(_ deleteTableCellBinding: @escaping (IndexPath) -> Void) {
        self.deleteTableCellBinding = deleteTableCellBinding
    }

    func onReloadTableCell(_ reloadTableCellBinding: @escaping (IndexPath) -> Void) {
        self.reloadTableCellBinding = reloadTableCellBinding
    }
}
