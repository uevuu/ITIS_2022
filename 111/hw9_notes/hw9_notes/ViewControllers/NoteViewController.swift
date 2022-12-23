import UIKit

class NoteViewController: UIViewController {
    
    var note: Note = .init(title: "Title", description: "Description", createData: "Create Data")
    var noteIndex: Int?
    
    private let titleTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 23)
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView.init(frame: .zero)
        textView.font = UIFont.systemFont(ofSize: 19)
        textView.layer.cornerRadius = 5
        textView.backgroundColor = .systemGray6
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        setupUp()
        setConstraints()
    }

    func setupUp() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped)),
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        ]

        navigationItem.title = "Note"
        
        titleTextField.text = note.title
        descriptionTextView.text = note.description
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
    }
    
    @objc private func saveTapped(){
        if titleTextField.text != ""{
            note.title = titleTextField.text!
            note.description = descriptionTextView.text ?? ""
            notesArray[noteIndex!] = note
            if let data = try? PropertyListEncoder().encode(notesArray) {
                    UserDefaults.standard.set(data, forKey: "SavedNotes")
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "Title can't be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func deleteTapped(){
        notesArray.remove(at: noteIndex!)
        if let data = try? PropertyListEncoder().encode(notesArray) {
                UserDefaults.standard.set(data, forKey: "SavedNotes")
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
