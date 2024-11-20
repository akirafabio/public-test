import UIKit

final class TodoViewController: UIViewController {
    private var viewModel: TodoViewModelInterface

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    init(viewModel: TodoViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func presentTodoAlert() {
        let alertViewController = AlertViewControllerFactory.todoAlert { [weak self] taskName in
            guard let taskName else {
                return
            }
            self?.viewModel.saveTask(taskName: taskName)
        }

        present(alertViewController, animated: true)
    }

    @objc private func backButtonTap() {
        viewModel.backButtonDidTouch()
    }

    @objc private func addButtonTap() {
        presentTodoAlert()
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

    func setupBinding() {
        viewModel.updateView { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
