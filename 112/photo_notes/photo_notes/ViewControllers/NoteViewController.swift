import UIKit

class NoteViewController: UIViewController {
    
    var note: Note = .init(type: .textNote, title: "Title", info: "Description", createData: "Create Data")
    var typeOfNote: noteType = .textNote
    let noteService: NoteService = .init()
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
    
    private let imageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        if typeOfNote == .textNote{
            descriptionTextView.text = note.info
            view.addSubview(descriptionTextView)
        }else{
            if note.info != nil{
                DispatchQueue.main.async { [self] in
                    imageView.image = try? noteService.getPhoto(imageIdentifier:(note.info)!)
                }
                view.addSubview(imageView)
            }
        }
    }
    
    @objc private func saveTapped(){
        if titleTextField.text != ""{
            note.title = titleTextField.text!
            if typeOfNote == .textNote{
                note.info = descriptionTextView.text ?? ""
            }else{
                let imageIdentifier: String?
                if imageView.image == nil{
                    imageIdentifier = nil
                }else{
                    imageIdentifier = UUID().uuidString
                    try? noteService.save(image: imageView.image!, imageIdentifier: imageIdentifier!)
                }
                note.info = imageIdentifier
            }
            notesArray[noteIndex!] = note
            noteService.saveTofile(notes: notesArray)
        }else{
            let alert = UIAlertController(title: "Error", message: "Title can't be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func deleteTapped(){
        notesArray.remove(at: noteIndex!)
        noteService.saveTofile(notes: notesArray)
        navigationController?.popViewController(animated: true)
    }
    
    func setConstraints() {
        if typeOfNote == .textNote{
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
        }else{
            NSLayoutConstraint.activate([
                titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                titleTextField.heightAnchor.constraint(equalToConstant: 50),
                
                imageView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
                imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}
