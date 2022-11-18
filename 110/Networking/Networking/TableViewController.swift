//
//  TableViewController.swift
//  Networking
//
//  Created by Teacher on 29.10.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private var customImageView: UIImageView!
    @IBOutlet private var customTextLabel: UILabel!

    var loadingTask: Task<Void, Never>?

    func set(text: String, imageUrl: URL) {
        customTextLabel.text = text
        loadingTask?.cancel()
        loadingTask = Task {
            await loadImage(url: imageUrl)
        }
    }

    private func loadImage(url: URL) async {
        customImageView.image = nil
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard !Task.isCancelled else { return }
            customImageView.image = UIImage(data: data)
        } catch {
            print("could not load image")
        }
    }
}

struct Response: Codable {
    struct User: Codable {
        let firstName: String
        let lastName: String
        let avatar: URL
        let email: String
        let id: Int
    }

    let data: [User]
}

class TableViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!

    private struct NamedImage {
        let title: String
        let url: URL
    }

    private var images: [NamedImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        Task {
            await loadUsers()
        }
    }

    private func loadUsers() async {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(Response.self, from: data)
            images = response.data.map { user in
                NamedImage(title: "\(user.firstName) \(user.lastName)", url: user.avatar)
            }

            tableView.reloadData()
        } catch {
            print("Got error loading users: \(error)")
        }
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        images.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                as? TableViewCell
        else {
            fatalError("Could not deque cell")
        }

        let image = images[indexPath.row]
        cell.set(text: image.title, imageUrl: image.url)
        return cell
    }
}
