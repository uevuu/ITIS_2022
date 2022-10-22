//
//  ViewController.swift
//  AutoLayout
//
//  Created by Teacher on 08.10.2022.
//

import UIKit

class MyLabel: UIView {
    var text: String = ""
    var font: UIFont = .systemFont(ofSize: 15)

    override var intrinsicContentSize: CGSize {
        text.size(withAttributes: [ .font: font ])
    }
}

class ViewController: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.text = "1231231231231231231231231231231231231231231231312312312312312312312312312312312312312312312312312312312312312312312312312313123123123123123123123123123123123123123123123123123123123123123123123123123131231231231231231231231231231231231231231231231231231231231231231231231231231312312312312312312312312312312312312312312312312312312312312312312312312312313123123123123123123123123123123"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStackView()
    }

    private func setupConstraintsWithAnchors() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        let centerYConstraint = label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerYConstraint.isActive = true

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func setupConstraintsDefault() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 1000),
            NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
        ])
    }

    private func setupStackView() {
        let loginField = UITextField()
        loginField.borderStyle = .roundedRect
        let passwordField = UITextField()
        passwordField.borderStyle = .roundedRect
        let hintLabel = UILabel()
        hintLabel.text = "Enter login/password"

        let stackView = UIStackView(
            arrangedSubviews: [ loginField, passwordField, hintLabel ]
        )
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        stackView.addArrangedSubview(submitButton)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

