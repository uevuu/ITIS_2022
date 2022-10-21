import UIKit

class CustomTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    enum Indentifier: String{
        case anime
        case manga
    }
    
    private var animeList: [Anime] = DataBase.getAnime()
    private var mangaList: [Manga] = DataBase.getManga()
    
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        var configuration = UIListContentConfiguration.cell()
        
        if indexPath.section == 0{
            let manga = mangaList[indexPath.row]
            
            if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Indentifier.manga.rawValue){
                cell = dequeuedCell
            }else{
                cell = UITableViewCell(style: .default, reuseIdentifier: Indentifier.manga.rawValue)
            }
            
            if manga.animeAdaptation{
                configuration.secondaryText = "Rating: \(manga.rating) / ✅ Anime adaptation"
            }
            else{
                configuration.secondaryText = "Rating: \(manga.rating) / ❌ Anime adaptation"
            }
            
            configuration.text = "\(manga.name)"
            configuration.image = UIImage(named: manga.publisherImg)
            configuration.imageProperties.maximumSize = CGSize(width: 50, height: 50)
            cell.contentConfiguration = configuration
            cell.backgroundColor = .systemGray6
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Indentifier.anime.rawValue, for: indexPath) as? CustomTableViewCell
            else{
                fatalError("Could not deque cell of type \(CustomTableViewCell.self)")
            }
            
            let anime = animeList[indexPath.row]
            cell.set(anime: anime)
            cell.backgroundColor = .systemGray6
            return cell
        }

    }
    


    private func setup() {
        view.backgroundColor = .systemGray4
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: Indentifier.anime.rawValue
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? mangaList.count : mangaList.count

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            tableView.deselectRow(at: indexPath, animated: true)
            print(animeList[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        indexPath.section == 0 ? false : true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Manga" : "Anime"
    }
}
