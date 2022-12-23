import UIKit

struct Note: Codable{
    var title: String
    var description: String
    var createData: String
}

var notesArray: [Note] = []

class NotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate {
    

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.data(forKey: "SavedNotes"){
            notesArray = try! PropertyListDecoder().decode([Note].self, from: data)
        }
        setUp()
        setupConstraint()
    }

    func setUp() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTapped))
        navigationItem.title = "All Notes"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    @objc private func composeTapped(){
        let addVC = AddNoteViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController()
        noteVC.note = notesArray[indexPath.row]
        noteVC.noteIndex = indexPath.row
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var configuration = UIListContentConfiguration.cell()
        configuration.text = notesArray[indexPath.row].title
        configuration.secondaryText = notesArray[indexPath.row].createData
        configuration.textProperties.font = UIFont.systemFont(ofSize: 23)
        configuration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
        cell.contentConfiguration = configuration
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            notesArray.remove(at: indexPath.row)
            if let data = try? PropertyListEncoder().encode(notesArray) {
                UserDefaults.standard.set(data, forKey: "SavedNotes")
            }
            tableView.deleteRows(at: [indexPath], with: .top)
            }

        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

