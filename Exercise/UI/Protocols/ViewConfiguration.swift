import Foundation

protocol ViewConfiguration {
    func buildLayout()
    func setupViewHierarchy()
    func setupViewConstraints()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func buildLayout() {
        setupViewHierarchy()
        setupViewConstraints()
        setupViewConfiguration()
    }
}
