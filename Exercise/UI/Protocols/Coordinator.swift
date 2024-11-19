protocol Coordinator: AnyObject {
    func start()
    func coordinatorDidFinish()
}

extension Coordinator {
    func coordinatorDidFinish() { }
}
