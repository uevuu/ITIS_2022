import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*
struct Thermometer {
    var degreesDidChange: () -> Void
    var degrees: Int {
        didSet {
            degreesDidChange()
        }
    }
}
*/

enum ThermometerError: Error {
    case connectionLost
}

var degreesPublisher: AnyPublisher<Int, ThermometerError>?

var degreesSubject: CurrentValueSubject<Int, ThermometerError> = .init(0)
degreesSubject.value = 5
degreesSubject.value += 1
degreesSubject.send(3)

var degreesSubject2: PassthroughSubject<Int, ThermometerError> = .init()
degreesSubject2.send(5)
degreesSubject2.send(1)
degreesSubject2.send(completion: .finished)
//degreesSubject2.send(completion: .failure(.connectionLost))

degreesPublisher = degreesSubject.eraseToAnyPublisher()

var cancellables: Set<AnyCancellable> = []
var mySubscription: AnyCancellable?

mySubscription = degreesPublisher?
//    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: { result in
        print("Completed with \(result)")
    }, receiveValue: { degrees in
        print("Current temperature is \(degrees) degrees")
    })
//    .store(in: &cancellables)

DispatchQueue.main.async {
    degreesSubject.value = 1
}
DispatchQueue.main.async {
    degreesSubject.value = 2
    mySubscription?.cancel()
}
DispatchQueue.main.async {
    degreesSubject.value = 3
}
DispatchQueue.main.async {
    degreesSubject.value = 4
}
DispatchQueue.main.async {
    degreesSubject.value = 5
}

//    .store(in: &cancellables)


/*

 class MyClass {
     var name: String = ""
 }

 struct MyStruct {
     var name: String = ""
 }

 func changeName(_ object: MyClass) {
     object.name = "123"
 }

 func changeName(_ myStruct: inout MyStruct) {
     myStruct.name = "123"
 }

 var myStruct = MyStruct()
 changeName(&myStruct)

 */
