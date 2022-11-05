import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

func loadUserProfile() async throws -> String {
    print("started loading profile")
    try await Task.sleep(for: .seconds(1))
    let result = "{ User: Amir }"
    print(result)
    return result
}
func loadUserSubscribers() async throws -> String {
    try await Task.sleep(for: .seconds(1))
    let result = "{ Subscribers: over9000 }"
    print(result)
    return result
}
func loadUserImage() async throws -> String {
    try await Task.sleep(for: .seconds(1))
    let result = "{ Image: Mountains }"
    print(result)
    return result
}

func loadUserAddressOld(_ completion: @escaping (Result<String, Error>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        let result = "{ Address: Kremlevskaya, 35 }"
        print(result)
        completion(.success(result))
    }
}

func loadUserAddress() async throws -> String {
    try await withUnsafeThrowingContinuation {
            (continuation: UnsafeContinuation<String, Error>) in
        loadUserAddressOld { result in
            switch result {
                case .success(let string):
                    continuation.resume(returning: string)
                case .failure(let error):
                    continuation.resume(throwing: error)
            }
        }
    }
}

func show(image: String, profile: String, subscribers: String) {
    print(image, profile, subscribers)
}

func loadUserInfo() async {
    do {
        let profile = try await loadUserProfile()
        let subscribers = try await loadUserSubscribers()
        let image = try await loadUserImage()
        let userAddress = try await loadUserAddress()
        show(image: image, profile: profile, subscribers: subscribers)
    } catch {
        print("Got error: \(error)")
    }
}

func loadUserInfoParallelly() async {
    do {
        async let profile = loadUserProfile()
        async let subscribers = loadUserSubscribers()
        async let image = loadUserImage()
        try await show(image: image, profile: profile, subscribers: subscribers)
    } catch {
        print("Got error: \(error)")
    }
}

print("Loading consecutively")
await loadUserInfo()

let task = Task {
    await loadUserInfo()
}
task.cancel()

print("Loading parallelly")
await loadUserInfoParallelly()

Task(priority: .userInitiated) {
    try await Task.sleep(for: .seconds(1))
    print("Hello, world")
}
