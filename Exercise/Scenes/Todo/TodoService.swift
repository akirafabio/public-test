import Foundation

protocol TodoServiceProtocol {
    func save(_ task: TodoTask, completion: @escaping (Bool) -> Void)
}

final class TodoService {
    private let successRate = 0.75
}

extension TodoService: TodoServiceProtocol {
    func save(_ task: TodoTask, completion: @escaping (Bool) -> Void) {
        let requestDelay = Int.random(in: 500...5_000)
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(requestDelay)) { [weak self] in
            guard let self else {
                return
            }
            let isTaskSaved = Double.random(in: 0...1) < self.successRate
            completion(isTaskSaved)
        }
    }
}
