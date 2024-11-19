protocol Coordinator: AnyObject {
    func start()
    func removeChildCoordinator()
}

extension Coordinator {
    func removeChildCoordinator() { }
}
