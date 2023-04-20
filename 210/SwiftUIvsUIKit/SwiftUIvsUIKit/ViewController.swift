//
//  ViewController.swift
//  SwiftUIvsUIKit
//
//  Created by Teacher on 15.04.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet
    private var loginField: UITextField!
    @IBOutlet
    private var passwordField: UITextField!
    @IBOutlet
    private var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.addAction(
            UIAction{ [weak self] _ in
                guard let self else { return }

                let hostingController = UIHostingController(
                    rootView: GroceriesView(
                        groceries: [
                            .init(name: loginField.text ?? ""),
                            .init(name: passwordField.text ?? "")
                        ]
                    )
                )
                navigationController?.pushViewController(hostingController, animated: true)
            },
            for: .touchUpInside
        )

        setupLogo()
    }

    private func setupLogo() {
        let logoController = UIHostingController(rootView: LogoView())
        guard let logoView = logoController.view else { return }

        addChild(logoController)
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        logoController.didMove(toParent: self)
    }
}

