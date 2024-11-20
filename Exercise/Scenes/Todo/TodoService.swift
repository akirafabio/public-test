import Foundation

protocol TodoServiceProtocol {
    func saveTask(task: String, completion: (Bool) -> Void)
}

final class TodoService {

}

extension TodoService: TodoServiceProtocol {
    func saveTask(task: String, completion: (Bool) -> Void) {
//        let minimumDelay = 500
//        let maximumDelay = 5_000
//        let millisecondsDelay = Int.random(in: minimumDelay...maximumDelay)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(millisecondsDelay)) {
//
//        }

        let randomRate = Int.random(in: 1...4)
        print(randomRate)

        switch randomRate {
        case 1:
            completion(false)
        default:
            completion(true)
        }
    }
}
