import Foundation

protocol ViewConfiguration {
    func buildLayout()
    func setupViewHierarchy()
    func setupViewConstraints()
    func setupViewConfiguration()
    func setupBinding()
}

extension ViewConfiguration {
    func buildLayout() {
        setupViewHierarchy()
        setupViewConstraints()
        setupViewConfiguration()
        setupBinding()
    }

    func setupBinding() { }
}
