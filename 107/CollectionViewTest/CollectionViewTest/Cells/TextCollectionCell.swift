//
//  TextCollectionCell.swift
//  CollectionViewTest
//
//  Created by Teacher on 22.10.2022.
//

import UIKit

class TextCollectionCell: UICollectionViewCell {
    static let font: UIFont = .systemFont(ofSize: 20)

    func set(text: String) {
        textLabel.text = text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    private let textLabel: UILabel = .init()

    private func setup() {
        contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
