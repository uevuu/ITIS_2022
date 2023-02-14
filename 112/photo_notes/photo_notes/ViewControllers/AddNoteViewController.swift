import UIKit
import PhotosUI

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate{
    
    var typeOfNote: noteType = .textNote
    let noteService: NoteService = .init()
    
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
        if typeOfNote == .textNote{
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNoteTapped))
        }else{
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNoteTapped)),
                UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .plain, target: self, action: #selector(addPhotoTapped))
            ]
        }
        navigationItem.title = "Create note"
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        if typeOfNote == .textNote{
            view.addSubview(descriptionTextView)
        }else{
            view.addSubview(imageView)
        }
    }
    
    @objc private func createNoteTapped(){
        if titleTextField.text != ""{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            var note: Note
            if typeOfNote == .textNote{
                note = Note(
                    type: .textNote, title: titleTextField.text ?? "",
                    info: descriptionTextView.text ?? "",
                    createData: dateFormatter.string(from: Date())
                )
            }else{
                let imageIdentifier: String?
                if imageView.image == nil{
                    imageIdentifier = nil
                }else{
                    imageIdentifier = UUID().uuidString
                    try? noteService.save(image: imageView.image!, imageIdentifier: imageIdentifier!)
                }
                note = Note(
                    type: .photoNote, title: titleTextField.text ?? "",
                    info: imageIdentifier,
                    createData: dateFormatter.string(from: Date())
                )
                try? noteService.save(note: note)
            }
            notesArray.insert(note, at: 0)
            noteService.saveTofile(notes: notesArray)
            navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "Title can't be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func addPhotoTapped(){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
          picker.dismiss(animated: true)
          results.forEach { result in
              print("Asset identifier: \(result.assetIdentifier ?? "none")")
              result.itemProvider.loadObject(ofClass: UIImage.self) { [self] reading, error in
                  if let error {
                      print("Got error loading image: \(error)")
                  } else if let image = reading as? UIImage {
                      DispatchQueue.main.async { [self] in
                          imageView.image = image
                      }
                  }
              }
          }
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
