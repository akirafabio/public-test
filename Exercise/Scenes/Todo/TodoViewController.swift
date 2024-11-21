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

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    private func presentTodoAlert() {
        let alertViewController = AlertViewControllerFactory.todoAlert { [weak self] taskName in
            guard let self else {
                return
            }
            guard let taskName else {
                return
            }
            self.viewModel.saveTask(taskName)
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
        tableView.delegate = self
    }

    func setupBinding() {
        viewModel.onUpdateView { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.onDeleteTableCell { [weak self] indexPath in
            self?.tableView.deleteRows(at: [indexPath], with: .left)
        }

        viewModel.onReloadTableCell { [weak self] indexPath in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withType: TodoTableCell.self, for: indexPath)

        if let task = viewModel.tasks[safe: indexPath.row] {
            tableCell.configure(with: task)
        }

        return tableCell
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let task = viewModel.tasks[safe: indexPath.row] else {
            return nil
        }

        if task.isSaving {
            return nil
        }

        let deleteSwipeAction = UIContextualAction(
            style: .destructive,
            title: Strings.Todo.deleteSwipeActionTitle,
            handler: { [weak self] _, _, complete in
                guard let self else {
                    complete(false)
                    return
                }
                self.viewModel.deleteSwipeActionDidTrigger(task)
                complete(true)
            }
        )

        return UISwipeActionsConfiguration(actions: [deleteSwipeAction])
    }
}
