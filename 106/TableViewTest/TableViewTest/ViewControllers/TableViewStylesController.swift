//
//  TableViewStylesController.swift
//  TableViewTest
//
//  Created by Teacher on 15.10.2022.
//

import UIKit

class TableViewStylesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        tableView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        10
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        section + 1
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "text") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(
                style: .default, reuseIdentifier: "text"
            )
        }

        var configuration = UIListContentConfiguration.cell()
        configuration.text = "Section: \(indexPath.section) Row: \(indexPath.row)"
        cell.contentConfiguration = configuration
        return cell
    }

//    func tableView(
//        _ tableView: UITableView, titleForHeaderInSection section: Int
//    ) -> String? {
//        "Section \(section) header"
//    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Section \(section) footer"
    }

    // MARK: - UITableViewDelegate

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let stackView = UIStackView()
        let label = UILabel()
        label.text = "Section \(section) header"
        label.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
        stackView.addArrangedSubview(label)
        return stackView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

//        present(MyScrollViewController(), animated: true)
        print("Selected row at \(indexPath)")
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
}
