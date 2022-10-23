//
//  CompositionalLayoutController.swift
//  CollectionViewTest
//
//  Created by Teacher on 22.10.2022.
//

import UIKit

class CompositionalLayoutController: UIViewController, UICollectionViewDataSource {
    private func promotedCellsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(320)
            ),
            repeatingSubitem: item, count: 1
        )
        let section = NSCollectionLayoutSection(
            group: group
        )
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func popularCellsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.33)
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(320)
            ),
            repeatingSubitem: item,
            count: 3
        )
        let section = NSCollectionLayoutSection(
            group: group
        )
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func updatesCellsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(50)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(300)
            ),
            repeatingSubitem: item, count: 1
        )
        let section = NSCollectionLayoutSection(
            group: group
        )
        return section
    }

    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] section, environment in
                guard let self else { fatalError("Self is nil") }
                guard let section = Section(rawValue: section) else {
                    fatalError("This section: (\(section)) does not exist")
                }

                switch section {
                    case .promotedApps:
                        return self.promotedCellsSection()
                    case .popular:
                        return self.popularCellsSection()
                    case .updates:
                        return self.updatesCellsSection()
                }
            },
            configuration: configuration
        )
        return UICollectionView(
            frame: .zero, collectionViewLayout: layout
        )
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        Section.allCases.forEach {
            collectionView.register(
                UICollectionViewCell.self, forCellWithReuseIdentifier: "\($0)"
            )
        }

        collectionView.dataSource = self
    }

    enum Section: Int, CaseIterable {
        case promotedApps
        case popular
        case updates
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        switch Section(rawValue: section) {
            case .promotedApps: return 5
            case .popular: return 9
            case .updates: return 10
            case nil: return 0
        }
    }

    private func cellContentConfiguration(section: Section) -> UIContentConfiguration {
        var configuration = UIListContentConfiguration.cell()
        switch section {
            case .promotedApps:
                configuration.image = UIImage(systemName: "house.fill")
            case .popular:
                configuration.image = UIImage(systemName: "star")
                configuration.text = "Popular app"
            case .updates:
                configuration.image = UIImage(systemName: "circle")
                configuration.text = "Update this app"
        }
        return configuration
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(section)", for: indexPath)
        cell.contentConfiguration = cellContentConfiguration(section: section)
        cell.contentView.backgroundColor = .lightGray
        return cell
    }
}
