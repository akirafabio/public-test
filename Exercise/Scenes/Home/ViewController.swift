//
//  ViewController.swift
//  Exercise
//

import UIKit

final class ViewController: UIViewController {
    var onAbout: (() -> Void) = {}

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("About", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchyViews()
        setupViewConstraints()
        setupView()
    }

    private func setupHierarchyViews() {
        view.addSubview(button)
    }

    private func setupViewConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    private func setupView() {
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(aboutButtonTap), for: .touchUpInside)
    }

    @objc private func aboutButtonTap() {
        onAbout()
    }
}
