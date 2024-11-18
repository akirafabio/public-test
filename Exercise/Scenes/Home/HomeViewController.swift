//
//  ViewController.swift
//  Exercise
//

import UIKit

final class HomeViewController: UIViewController {
    var onAbout: (() -> Void) = {}

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Home.aboutButtonTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    @objc private func aboutButtonTap() {
        onAbout()
    }
}

extension HomeViewController: ViewConfiguration {
    func setupViewHierarchy() {
        view.addSubview(button)
    }

    func setupViewConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    func setupViewConfiguration() {
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(aboutButtonTap), for: .touchUpInside)
    }
}
