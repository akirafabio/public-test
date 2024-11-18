//
//  AboutViewController.swift
//  Exercise
//

import UIKit

class AboutViewController: UIViewController {
    var onClose: (() -> Void) = {}

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Strings.About.label
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc private func closeTap() {
        onClose()
    }
}

extension AboutViewController: ViewConfiguration {
    func setupViewHierarchy() {
        view.addSubview(label)
    }

    func setupViewConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    func setupViewConfiguration() {
        navigationItem.title = Strings.About.title
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(closeTap))
        view.backgroundColor = .white
    }
}
