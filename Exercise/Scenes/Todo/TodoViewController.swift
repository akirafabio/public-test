import UIKit

final class TodoViewController: UIViewController {
    private var backButtonAction: (() -> Void)?
    private var addButtonAction: (() -> Void)?

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    required init?(coder: NSCoder) { nil }

    init() {
        super.init(nibName: nil, bundle: nil)
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
        view.addSubview(tableView)
    }

    func setupViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
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

        tableView.dataSource = self
    }
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
