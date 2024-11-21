import UIKit

final class HomeViewController: UIViewController {
    private var todoButtonAction: (() -> Void)?
    private var aboutButtonAction: (() -> Void)?

    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    private let todoButton: UIButton = {
        let aboutButton = UIButton()
        aboutButton.setTitleColor(.systemBlue, for: .normal)
        aboutButton.backgroundColor = .secondarySystemBackground
        return aboutButton
    }()
    private let aboutButton: UIButton = {
        let aboutButton = UIButton()
        aboutButton.setTitle(Strings.Home.aboutButtonTitle, for: .normal)
        aboutButton.setTitleColor(.systemBlue, for: .normal)
        aboutButton.backgroundColor = .secondarySystemBackground
        return aboutButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateView()
    }

    @objc private func aboutButtonTap() {
        aboutButtonAction?()
    }

    @objc private func todoButtonTap() {
        todoButtonAction?()
    }

    @discardableResult
    func onAboutButtonClick(_ action: (() -> Void)?) -> Self {
        self.aboutButtonAction = action
        return self
    }

    @discardableResult
    func onTodoButtonClick(_ action: (() -> Void)?) -> Self {
        self.todoButtonAction = action
        return self
    }
}

extension HomeViewController: ViewConfiguration {
    func setupViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoButton)
        stackView.addArrangedSubview(aboutButton)
    }

    func setupViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            .isActive = true
    }

    func setupViewConfiguration() {
        view.backgroundColor = .white

        aboutButton.addTarget(self, action: #selector(aboutButtonTap), for: .touchUpInside)

        todoButton.addTarget(self, action: #selector(todoButtonTap), for: .touchUpInside)
    }

    func updateView() {
        todoButton.setTitle(Strings.Home.todoButtonTitle(arg: "\(AppTaskManager.shared.tasks.count)"), for: .normal)
    }
}
