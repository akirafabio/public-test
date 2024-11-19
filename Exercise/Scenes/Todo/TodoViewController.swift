import UIKit

final class TodoViewController: UIViewController {
    private var backButtonAction: (() -> Void)?
    private var addButtonAction: (() -> Void)?

    required init?(coder: NSCoder) { nil }

    init() {
        print("[TEST] \(Self.self) \(#function)")
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        print("[TEST] \(Self.self) \(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    @objc private func backButtonTap() {
        backButtonAction?()
    }

    @objc private func addButtonTap() {
        addButtonAction?()
    }

    @discardableResult
    func onBackButtonClick(_ action: (() -> Void)?) -> Self {
        self.backButtonAction = action
        return self
    }

    @discardableResult
    func onAddButtonClick(_ action: (() -> Void)?) -> Self {
        self.addButtonAction = action
        return self
    }
}

extension TodoViewController: ViewConfiguration {
    func setupViewHierarchy() {
    }

    func setupViewConstraints() {
    }

    func setupViewConfiguration() {
        navigationItem.leftBarButtonItem = .init(
            image: UIImage.chevronLeft,
            style: .plain,
            target: self,
            action: #selector(backButtonTap)
        )

        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTap)
        )
        view.backgroundColor = .white
    }
}
