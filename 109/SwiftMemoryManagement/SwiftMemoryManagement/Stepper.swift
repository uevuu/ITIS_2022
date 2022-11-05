//
//  Stepper.swift
//  SwiftMemoryManagement
//
//  Created by Teacher on 05.11.2022.
//

import UIKit

class Stepper: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    var count: Int {
        counterLabel.text.flatMap { Int($0) } ?? 0
    }

    func set(count: Int) {
        counterLabel.text = "\(count)"
    }

    private func setup() {
        let stackView = UIStackView(arrangedSubviews: [
            plusButton, counterLabel, minusButton
        ])
        counterLabel.text = "0"
        counterLabel.textAlignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    var plusTap: (() -> Void)?
    var minusTap: (() -> Void)?

    private lazy var plusButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "+"
        return UIButton(
            configuration: configuration,
            primaryAction: UIAction { [unowned self] _ in
                plusTap?()
            }
        )
    }()

    private lazy var minusButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "-"
        return UIButton(
            configuration: configuration,
            primaryAction: UIAction { [unowned self] action in
                minusTap?()
            }
        )
    }()

    private let counterLabel: UILabel = .init()
}
