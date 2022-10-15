//
//  CustomTableViewController.swift
//  TableViewTest
//
//  Created by Teacher on 15.10.2022.
//

import UIKit

class CustomTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private let tableView: UITableView = .init()

    private func setup() {
        view.backgroundColor = .systemGray3
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        aliens = (0 ..< 100).map { _ in
            Alien.random()
        }

        tableView.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CellIdentifier.alien.rawValue
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    private var aliens: [Alien] = []

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        aliens.count
    }

    enum CellIdentifier: String {
        case alien
        case text
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: CellIdentifier.alien.rawValue, for: indexPath
                )
                as? CustomTableViewCell
        else {
            fatalError("Could not deque cell of type \(CustomTableViewCell.self)")
        }

        let alien = aliens[indexPath.row]
        cell.set(alien: alien)
        return cell
    }
}
