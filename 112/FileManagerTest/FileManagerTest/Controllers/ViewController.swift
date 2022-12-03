//
//  ViewController.swift
//  FileManagerTest
//
//  Created by Teacher on 03.12.2022.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
        PHPickerViewControllerDelegate {
    let noteService: NoteService = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        print((try? noteService.notesList()) ?? [])
    }

    @IBAction
    private func addNoteTap() {
        guard
            let controller: NoteController = storyboard?
                .instantiateViewController(identifier: "NoteController")
        else {
            fatalError("Could not instantiate NoteController")
        }

        controller.noteService = noteService
        present(controller, animated: true)
    }

    @IBAction
    private func captureImageTap() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.cameraCaptureMode = .photo
        present(imagePicker, animated: true)
    }

    @IBAction
    private func pickImageTap() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 3
        configuration.filter = .images
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }

    // Image picker

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else { return }

        try? noteService.save(image: image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    // PHPicker

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        results.forEach { result in
            print("Asset identifier: \(result.assetIdentifier ?? "none")")
            result.itemProvider.loadObject(ofClass: UIImage.self) { [self] reading, error in
                if let error {
                    print("Got error loading image: \(error)")
                } else if let image = reading as? UIImage {
                    print("Got image of size: \(image.size)")
                    try? noteService.save(image: image)
                }
            }
        }
    }
}

