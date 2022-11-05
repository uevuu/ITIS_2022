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

    @MainActor
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

class TableViewController: UIViewController, UITableViewDataSource {
    private struct NamedImage {
        let title: String
        let url: URL
    }

    private let images: [NamedImage] = [
        .init(title: "guinea-pig", url: URL(string: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/guinea-pig-1663940975.jpg")!),
        .init(title: "cat", url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzofU_IVyvjE6FT2-5yablwZ3Ar6DbN1k68C8VMIKKG5uUa5I1d4-nsQ6aORyJ7opO5QU&usqp=CAU")!),
        .init(title: "dog", url: URL(string: "https://i.guim.co.uk/img/static/sys-images/Guardian/Pix/pictures/2014/1/20/1390229376041/1773f12e-7ddc-4f65-ae31-ef0fbba4f4d4-620x372.png?width=620&quality=85&auto=format&fit=max&s=d9153412cec194021055d835150546f0")!),
        .init(title: "hedgehog", url: URL(string: "https://ih1.redbubble.net/image.1287348073.7546/flat,750x,075,f-pad,750x1000,f8f8f8.jpg")!),
        .init(title: "bee", url: URL(string: "https://sayingimages.com/wp-content/uploads/i-duuno-man-bee-meme.jpg")!),
        .init(title: "straus", url: URL(string: "https://i.imgflip.com/2ncskm.jpg")!),
        .init(title: "wolf", url: URL(string: "https://ic.pics.livejournal.com/gleb_klinov/13484857/65728/65728_original.jpg")!),
        .init(title: "bear", url: URL(string: "https://i.pinimg.com/736x/d9/e0/f1/d9e0f167f32be5e52baacaafb07b020d.jpg")!),
        .init(title: "fox", url: URL(string: "https://www.meme-arsenal.com/memes/b3137cc969c9357b1dfc2a8078adac07.jpg")!),
        .init(title: "pterodactyl", url: URL(string: "https://i.pinimg.com/originals/10/6d/cd/106dcdfe8edde8d6799d4872d70cd4ad.jpg")!),
        .init(title: "t-rex", url: URL(string: "https://i.imgflip.com/1meffy.jpg")!),
        .init(title: "honeybadger", url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6vxC1mszZrlluRk8oFsQ2eMTm8jL7Y9i5wg&usqp=CAU")!),
        .init(title: "MPZ", url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/e/ec/Bethlehem_Steel.jpg")!),
        .init(title: "pig", url: URL(string: "https://i.redd.it/t3f0w3kgvsp61.jpg")!),
        .init(title: "horse", url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPs08SWS4Wo7xankoOIiV44yaIusNVud0qkinHpLAVVXE_fYVFjLPqoVfiwkEDcF6k9OI&usqp=CAU")!),
        .init(title: "mouse", url: URL(string: "https://www.meme-arsenal.com/memes/ddaf930c4d96eb52a34dc158410e6618.jpg")!),
    ]

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
