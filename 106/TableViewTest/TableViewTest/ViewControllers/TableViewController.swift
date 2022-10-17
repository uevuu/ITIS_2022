//
//  TableViewController.swift
//  TableViewTest
//
//  Created by Teacher on 15.10.2022.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private let tableView: UITableView = .init()

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        tableView.dataSource = self
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        10000
    }

    var allCells: Set<UITableViewCell> = []

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        // let section = indexPath.section
        // let row = indexPath.row

        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "text") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(
                style: .default, reuseIdentifier: "text"
            )
        }

        if allCells.insert(cell).inserted {
            print("Added cell: \(cell)")
        }

        var configuration = UIListContentConfiguration.cell()
        configuration.text = "Hello, world #\(indexPath.row)"
        cell.contentConfiguration = configuration
        return cell
    }
}
