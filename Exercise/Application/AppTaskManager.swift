final class AppTaskManager {

    static let shared: AppTaskManager = AppTaskManager()

    private(set) var tasks: [TodoTask]

    private init() {
        self.tasks = []
    }

}
