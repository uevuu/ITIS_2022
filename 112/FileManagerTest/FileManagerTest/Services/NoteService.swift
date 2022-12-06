//
//  NoteService.swift
//  FileManagerTest
//
//  Created by Teacher on 03.12.2022.
//

import UIKit

enum NoteServiceError: Error {
    case fileNotFound
    case couldNotReadFile
    case couldNotCreateFileName
    case couldNotCreateImageData
}

class NoteService {
    private let fileManager: FileManager
    private let documentsDirectory: URL
    private let noteExtension: String = "json"
    private let imageExtension: String = "png"

    init() {
        fileManager = .default

        guard let documentsDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Could not load documents directory")
        }
        self.documentsDirectory = documentsDirectory
        print("Initialized documents directory at \(documentsDirectory.path())")
    }

    func notesList() throws -> [String] {
        try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            .map { $0.deletingPathExtension().lastPathComponent }
    }

    func save(note: Note) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(note)
        guard let noteTitle = encode(string: "\(note.title).\(noteExtension)") else {
            throw NoteServiceError.couldNotCreateFileName
        }

        let path = documentsDirectory.path().appending(noteTitle)
        fileManager.createFile(atPath: path, contents: data)
    }

    func readNote(title: String) throws -> Note {
        let path = documentsDirectory.appending(path: "\(title).\(noteExtension)").path()
        guard fileManager.fileExists(atPath: path) else {
            throw NoteServiceError.fileNotFound
        }

        guard let data = fileManager.contents(atPath: path) else {
            throw NoteServiceError.couldNotReadFile
        }

        let decoder = JSONDecoder()
        let note = try decoder.decode(Note.self, from: data)
        return note
    }

    func save(image: UIImage) throws {
        guard let data = image.pngData() else {
            throw NoteServiceError.couldNotCreateImageData
        }
        guard let imageTitle = encode(string: "\(UUID().uuidString).\(imageExtension)") else {
            throw NoteServiceError.couldNotCreateFileName
        }

        let path = documentsDirectory.appending(path: imageTitle).path()
        fileManager.createFile(atPath: path, contents: data)
    }

    private func encode(string: String) -> String? {
        string.addingPercentEncoding(
            withAllowedCharacters: .init(charactersIn: " ()")
                .union(.urlPathAllowed)
        )
    }
}
