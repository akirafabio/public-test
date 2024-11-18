//
//  ViewController.swift
//  Exercise
//

import UIKit

class ViewController: UIViewController {
	var onAbout: (() -> Void) = {}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("About", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.addTarget(self, action: #selector(aboutButtonTap), for: .touchUpInside)

		view.addSubview(button)

		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
		])
	}

	@objc private func aboutButtonTap() {
		onAbout()
	}
}
