//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Teacher on 22.10.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 30
        return .init(
            frame: .zero, collectionViewLayout: layout
        )
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        view.backgroundColor = .systemBackground

        collectionView.contentInsetAdjustmentBehavior = .always
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        collectionView.register(TextCollectionCell.self, forCellWithReuseIdentifier: Cell.Identifier.text)
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: Cell.Identifier.image)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Cell.Identifier.textAndImage)

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

    enum Cell {
        case text(String)
        case image(UIImage)
        case textAndImage(String, UIImage)

        enum Identifier {
            static let text: String = "text"
            static let image: String = "image"
            static let textAndImage: String = "text/image"
        }
    }

    private var cells: [Cell] = [
        .text("Hello"),
        .text("World"),
        .text("HelloWorld HelloWorld HelloWorldHelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld"),
        .text("World"),
        .text("Hello"),
        .text("World"),
        .image(.init(systemName: "circle")!),
        .text("Hello"),
        .text("World"),
        .text("Hello"),
        .image(.init(systemName: "circle.fill")!),
        .text("World"),
        .text("Hello"),
        .image(.init(systemName: "11.circle.fill")!),
        .image(.init(systemName: "12.circle")!),
        .image(.init(systemName: "13.circle")!),
        .text("World"),
        .text("Hello"),
        .text("World"),
        .image(.init(systemName: "person")!),
        .image(.init(systemName: "house")!),
        .text("Hello"),
        .text("World"),
        .textAndImage("123123", .init(systemName: "person")!),
        .textAndImage("123123", .init(systemName: "person")!),
        .textAndImage("HelloWorld HelloWorld HelloWorldHelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld", .init(systemName: "person")!),
        .textAndImage("123123", .init(systemName: "person")!),
        .textAndImage("123123", .init(systemName: "person")!),
        .textAndImage("HelloWorld HelloWorld HelloWorldHelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld", .init(systemName: "house")!),
        .textAndImage("123123", .init(systemName: "person")!),
        .text("Hello"),
        .text("World"),
        .text("Hello"),
        .text("World"),
        .text("Hello"),
        .text("World"),
        .text("Hello"),
        .text("World"),
        .text("Hello"),
        .text("World"),
        .text("Hello"),
        .text("World"),
    ]

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        cells.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cellData = cells[indexPath.item]
        switch cellData {
            case .text(let string):
                guard
                    let cell = collectionView
                        .dequeueReusableCell(
                            withReuseIdentifier: Cell.Identifier.text, for: indexPath
                        )
                        as? TextCollectionCell
                else {
                    fatalError("Could not deuque cell of type \(TextCollectionCell.self)")
                }
                cell.set(text: string)
                return cell
            case .image(let image):
                guard
                    let cell = collectionView
                        .dequeueReusableCell(
                            withReuseIdentifier: Cell.Identifier.image, for: indexPath
                        )
                        as? ImageCollectionCell
                else {
                    fatalError("Could not deuque cell of type \(TextCollectionCell.self)")
                }

                cell.set(image: image)
                return cell
            case .textAndImage(let string, let image):
                var configuration = UIListContentConfiguration.cell()
                configuration.text = string
                configuration.image = image
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.Identifier.textAndImage, for: indexPath)
                cell.contentConfiguration = configuration
                return cell
        }
    }

    private let imageAndTextCellForSizing: UICollectionViewCell = .init()

    private func sizeOfCell(text: String, image: UIImage) -> CGSize {
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.image = image
        contentConfiguration.text = text
        imageAndTextCellForSizing.contentConfiguration = contentConfiguration
        var size = imageAndTextCellForSizing.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        )
        size.width = min(size.width, collectionView.bounds.width)
        return size
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellData = cells[indexPath.item]
        switch cellData {
            case .text(let string):
                let stringWidth = string.size(
                    withAttributes: [ .font: TextCollectionCell.font ]
                ).width
                return CGSize(
                    width: min(stringWidth, collectionView.bounds.width),
                    height: 50
                )
            case .image:
                return CGSize(width: 50, height: 50)
            case .textAndImage(let text, let image):
                return sizeOfCell(text: text, image: image)
        }
    }
}

