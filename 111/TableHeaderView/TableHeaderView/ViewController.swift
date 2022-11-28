//
//  ViewController.swift
//  TableHeaderView
//
//  Created by Teacher on 26.11.2022.
//

import UIKit

class ProfileView: UIView {
    let imageView: UIImageView = .init(image: UIImage(systemName: "house"))
    let titleLabel: UILabel = .init()
    let descriptionLabel: UILabel = .init()

    func setup() {
        backgroundColor = .systemGray3
        [ imageView, titleLabel, descriptionLabel ].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            descriptionLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -10),
            descriptionLabel.topAnchor
                .constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -10),
        ])
        descriptionLabel.numberOfLines = 0
        titleLabel.text = "Some house"
        descriptionLabel.text = """
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor
        Finish
        """
    }
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet
    private var tableView: UITableView!

    private var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tableHeaderView = ProfileView()
        tableHeaderView.setup()
        tableHeaderView.layoutIfNeeded()
        headerView = tableHeaderView

        tableView.register(
            UITableViewCell.self, forCellReuseIdentifier: "Cell"
        )
    }

    enum Section {
        case header
        case rows([String])
    }

    var sections: [Section] = [.header, .rows(["1", "2", "3"])]

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let profileView = ProfileView()
        profileView.setup()
        profileView.widthAnchor
            .constraint(equalToConstant: view.bounds.width)
            .isActive = true
        let size = profileView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var configuration = UIListContentConfiguration.cell()
        configuration.text = "\(indexPath.row)"
        cell.contentConfiguration = configuration
        return cell
    }
}

