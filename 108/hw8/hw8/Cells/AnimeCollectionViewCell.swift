import UIKit

class AnimeCollectionViewCell: UICollectionViewCell{
    
    private var dataTask: URLSessionDataTask?

    private let animeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setConstraint()
    }
    
    func setupView(){
        backgroundColor = .none
        addSubview(animeImageView)
    }
    
    func configureCell(imageName: String){
        loadImage(url: URL(string: imageName)!)
        animeImageView.contentMode = .scaleAspectFit
    }
    
    private func loadImage(url: URL) {
        animeImageView.image = nil
        dataTask?.cancel()
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        dataTask = URLSession.shared
            .dataTask(with: urlRequest) { [animeImageView] data, _, _ in
                guard let data else {
                    return
                }

                let image = UIImage(data: data)
                DispatchQueue.main.async { [animeImageView] in
                    guard let image else { return }
                    animeImageView.image = image
                }
            }
        dataTask?.resume()
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            animeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            animeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            animeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            animeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
    }
}
