//
//  CustomTableViewCell.swift
//  TableViewTest
//
//  Created by Teacher on 15.10.2022.
//

import UIKit

struct Alien {
    let name: String
    let age: Int
    let numberOfLimbs: Int

    public static func random() -> Alien {
        Alien(
            name: randomName(), age: Int.random(in: 0..<1000),
            numberOfLimbs: Int.random(in: 0...10)
        )
    }

    private static func randomName() -> String {
        [
            "Mike", "Paul", "Gree", "Apple", "Acer", "Samsung", "XIAOMI"
        ]
        .randomElement() ?? ""
    }
}

class CustomTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    private let nameLabel: UILabel = .init()
    private let ageLabel: UILabel = .init()
    private let limbsNumberImageView: UIImageView = .init()

    func set(alien: Alien) {
        nameLabel.text = alien.name
        ageLabel.text = "Age: \(alien.age)"
        limbsNumberImageView.image = UIImage(
            systemName: "\(alien.numberOfLimbs).circle.fill"
        )
    }

    private func setup() {
        nameLabel.font = .boldSystemFont(ofSize: 20)
        ageLabel.font = .monospacedDigitSystemFont(ofSize: 17, weight: .regular)
        let limbsLabel = UILabel()
        limbsLabel.text = "# of limbs:"
        let limbsStackView = UIStackView(
            arrangedSubviews: [ limbsLabel, limbsNumberImageView ]
        )
        limbsStackView.spacing = 10
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel, ageLabel, limbsStackView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        limbsNumberImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            limbsNumberImageView.widthAnchor.constraint(equalToConstant: 30),
            limbsNumberImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
