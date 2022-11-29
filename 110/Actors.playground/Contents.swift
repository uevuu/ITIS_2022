import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class SafeArray<Element> {
    private var array: [Element] = []

    private let workQueue: DispatchQueue = .init(label: "SafeArrayQueue")

    func get(elementAt index: Int, completion: @escaping (Element) -> Void) {
        workQueue.sync {
            completion(array[index])
        }
    }

    func set(element: Element, at index: Int, completion: @escaping () -> Void) {
        workQueue.sync(flags: .barrier) {
            array[index] = element
            completion()
        }
    }
}

struct User {
    let name: String
}

actor UsersData {
    var users: [User] = []
    var remainingEarthPopulation: Int = 8_000_000_000

    func generateNewUser() {
        users.append(User(name: UUID().uuidString))
        remainingEarthPopulation -= 1
    }

    nonisolated func getUsers() async -> [User] {
        return await users
    }
}

func getFirstUser(from usersData: UsersData) async -> User? {
    await print("We now have \(usersData.remainingEarthPopulation) potential users")
    return await usersData.users.first
}

func add(user: User, to usersData: isolated UsersData) {
    usersData.users.append(user)
    usersData.remainingEarthPopulation -= 1
    usersData.generateNewUser()
}

let usersData = UsersData()
await add(user: User(name: "Amir"), to: usersData)
await usersData.generateNewUser()

class MyClassThatWorksOnMainThread {
    func foo() async {
        try? await Task.sleep(for: .seconds(1))
        await MainActor.run {
            let view = UIView()
            view.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        }
    }
}
