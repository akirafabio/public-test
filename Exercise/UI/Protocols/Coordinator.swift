protocol Coordinator: AnyObject {
    func start()
    func removeFromParent()
}

extension Coordinator {
    func removeFromParent() { }
}
