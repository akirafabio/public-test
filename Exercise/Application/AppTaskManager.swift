final class AppTaskManager {

    static let shared: AppTaskManager = AppTaskManager()

    private(set) var tasks: [TodoTask]

    private init() {
        self.tasks = []
    }

    func store(_ tasks: [TodoTask]) {
        self.tasks = tasks.filter { !$0.isSaving }
    }
}
