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
    private let archiveURL: URL
    private let noteExtension: String = "json"
    private let imageExtension: String = "png"
    
    
    init() {
        fileManager = .default
        
        guard let documentsDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Could not load documents directory")
        }
        self.documentsDirectory = documentsDirectory
        self.archiveURL = documentsDirectory.appendingPathComponent("notes").appendingPathExtension("plist")
        print("Initialized documents directory at \(documentsDirectory.path())")
    }
    
    func saveTofile(notes: [Note]){
        let encoder = PropertyListEncoder()
        let codeNotes = try? encoder.encode(notes)
        try? codeNotes?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func loadFromFile() -> [Note]{
        guard let codeNotes = try? Data(contentsOf: archiveURL) else {return []}
        let decoder = PropertyListDecoder()
        return try! decoder.decode([Note].self, from: codeNotes)
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
    
    func save(image: UIImage, imageIdentifier: String) throws {
        guard let data = image.pngData() else {
            throw NoteServiceError.couldNotCreateImageData
        }
        guard let imageTitle = encode(string: "\(imageIdentifier).\(imageExtension)") else {
            throw NoteServiceError.couldNotCreateFileName
        }
        
        let path = documentsDirectory.appending(path: imageTitle).path()
        print(path)
        fileManager.createFile(atPath: path, contents: data)
    }
    
    func getPhoto(imageIdentifier: String) throws -> UIImage{
        let path  = documentsDirectory.appendingPathExtension("\(imageIdentifier).\(imageExtension)").path()
        guard fileManager.fileExists(atPath: path) else{
            throw NoteServiceError.fileNotFound
        }
        guard let data = fileManager.contents(atPath: path) else{
            throw NoteServiceError.couldNotReadFile
        }
        return  UIImage(data: data)!
    }

    private func encode(string: String) -> String? {
        string.addingPercentEncoding(
            withAllowedCharacters: .init(charactersIn: " ()")
                .union(.urlPathAllowed)
        )
    }
}
