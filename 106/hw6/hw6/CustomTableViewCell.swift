import UIKit


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
    private let ratingLabel: UILabel = .init()
    private let seriesLabel: UILabel = .init()
    private let studioLabel: UILabel = .init()
    private let animeImageView: UIImageView = .init()

    func set(anime: Anime) {
        nameLabel.text = anime.name
        ratingLabel.text = "Rating: \(anime.rating)"
        seriesLabel.text = "Series: \(anime.series_out)/\(anime.series_total)"
        studioLabel.text = "Studio: \(anime.studio)"
        animeImageView.image = UIImage(named: anime.image)
    }

    private func setup() {
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        
        ratingLabel.font = .systemFont(ofSize: 17)
        seriesLabel.font = .systemFont(ofSize: 17)
        studioLabel.font = .systemFont(ofSize: 13, weight: .thin)
        let infoStackView = UIStackView(arrangedSubviews: [ ratingLabel, seriesLabel])
        let stackView = UIStackView(arrangedSubviews: [nameLabel, animeImageView, studioLabel])
        
        stackView.spacing = 10
        infoStackView.axis = .vertical
        stackView.axis = .vertical
        infoStackView.alignment = .leading
        stackView.alignment = .leading
        
        contentView.addSubview(stackView)
        contentView.addSubview(infoStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            infoStackView.leadingAnchor.constraint(equalTo: animeImageView.trailingAnchor, constant: 10),
            infoStackView.centerYAnchor.constraint(equalTo: animeImageView.centerYAnchor),
            animeImageView.widthAnchor.constraint(equalToConstant: 180),
            animeImageView.heightAnchor.constraint(equalToConstant: 257)
        ])
    }
}
