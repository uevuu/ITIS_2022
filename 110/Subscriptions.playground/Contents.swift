import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct WalletBalance: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Int
    var userBalance: Element = 0

    mutating func next() async -> Element? {
        try? await Task.sleep(for: .milliseconds(250))
        userBalance += 5
        return userBalance
    }

    func makeAsyncIterator() -> WalletBalance {
        self
    }
}

class UserWalletService {
    var userBalance: Int = 0 {
        didSet {
            balanceChanged.forEach { $0() }
        }
    }
    var balanceChanged: [() -> Void] = []

    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) { [weak self] in
            guard let self else { return }

            self.userBalance += 5
            self.start()
        }
    }
}

class ViewController: UIViewController {
    private var walletService: UserWalletService!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    deinit {
        updateTask?.cancel()
    }

    let walletBalance = WalletBalance()
    var updateTask: Task<Void, Never>?

    func setup() {
        updateTask = Task {
            for await balance in walletBalance {
                guard !Task.isCancelled else { return }

                print("Balance: \(balance)")
            }
        }
    }
}

var viewController: ViewController? = ViewController()
viewController?.setup()

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
    viewController?.updateTask?.cancel()
}
