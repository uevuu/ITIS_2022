import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let sections  = MyData().pageData
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        collectionView.dataSource = self
        collectionView.delegate = self
        setConstraints()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section]{
            
        case .anime(let anime):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCollectionViewCell", for: indexPath) as? AnimeCollectionViewCell else {return UICollectionViewCell()}
            cell.configureCell(imageName: anime[indexPath.row].image)
            return cell
        case .wallpaper(let wallpaper):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCollectionViewCell", for: indexPath) as? WallpaperCollectionViewCell else {return UICollectionViewCell()}
            cell.configureCell(title: wallpaper[indexPath.row].title, imageName: wallpaper[indexPath.row].image, imageSize: wallpaper[indexPath.row].size)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as! HeaderSupplementaryView
            header.configureCell(headerName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    private func setupView(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(AnimeCollectionViewCell.self, forCellWithReuseIdentifier: "AnimeCollectionViewCell")
        collectionView.register(WallpaperCollectionViewCell.self, forCellWithReuseIdentifier: "WallpaperCollectionViewCell")
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    
    private func createLayout() -> UICollectionViewCompositionalLayout{

        UICollectionViewCompositionalLayout{[weak self] sectionIndex, _ in
            guard let self = self else {return nil}
            let section = self.sections[sectionIndex]
            switch section{
            case .anime(_):
                return self.createAnimeSection()
            case .wallpaper(_):
                return self.createWallpaperSection()
            }
        }
    }
    
    private func createAnimeSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 2, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.05)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createWallpaperSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.05)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 22, bottom: 0, trailing: 0)
        return section
    }
}
