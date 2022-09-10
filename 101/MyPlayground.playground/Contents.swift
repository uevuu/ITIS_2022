import UIKit

// Int, String, Bool, Double, Float
// Set, Dictionary, Array
// class, struct, enum, protocol, tuple, extension

/*
var a: Double = 0
let b = a

print(a)
print(b)
a += 1
print(a)
print(b)

var myString = "Hello, world"
print(myString)

myString += " again"
print(myString)

a += 0.5

var mySet: Set = [1, 2, 3]
print(type(of: mySet))

func myPrintBad(_ value: any Numeric) {
    print(value)
}

func myPrint<T: Numeric>(_ value: T) {
    print(value)
}

myPrint(a)
myPrint(1)

class MyClass: Hashable {
    init(name: String) {
        self.name = name
    }
    let name: String
    static var name: String = "MyClass.default"

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        print(Self.name)
    }

    static func == (lhs: MyClass, rhs: MyClass) -> Bool {
        lhs.name == rhs.name
    }
}

var myArray: [Any] = ["", 1, 1.0, MyClass(name: "Hello")]
print(myArray)

var mySet2: Set<MyClass>

let myClass1 = MyClass(name: "123")
print("myClass1.name: \(myClass1.name)")
print("MyClass.name: \(MyClass.name)")

var myDictionary: [String: String] = [
    "Hello": "World",
    "room": "1412"
]

myDictionary["floor"] = "14"
print(myDictionary)
myDictionary["Hello"] = nil
print(myDictionary)

// inout

func foo(taking bar: Int) {
}

func foo() {
}

func foo(barBar: Int) -> Int {
    print("Hello")
    return barBar
}

func foo2(barBar: Int) -> Int {
    barBar
}

func foo3() -> Int {
    Int.random(in: 1...2)
}

func foo4(myString: inout String) {
    myString += "Hello world"
}

func foo(myString: String) -> String {
    myString + "Hello, world"
}

let myString2 = ""
var myString3 = myString2
foo4(myString: &myString3)
print(myString2)
print(foo(myString: ""))
*/

class Animal {
    var numberOfLegs: Int { 4 }

    func makeSound() {
        if qrCode() < 500000 {
            print("Yyyyyyiiiiiii")
        }
    }

    private func qrCode() -> Int {
        Int.random(in: 0...999999)
    }
}

protocol Humanoid {
    var hasFur: Bool { get }
    var age: Int { get set }
}

class Human: Animal, Humanoid {
    let hasFur: Bool = false
    var age: Int = 0

    var name: String = ""
    override var numberOfLegs: Int { 2 }

    override func makeSound() {
//        super.makeSound()

        print("Привет, I don't have \(super.numberOfLegs) legs, I have \(numberOfLegs) legs")
    }
}

let human1 = Human()
// Cannot assign to property: 'hasFur' is a 'let' constant
// human1.hasFur = true
print(human1.hasFur)

let humanoid1: Humanoid = human1
humanoid1.hasFur

human1.makeSound()

protocol MakingSound {
    func makeSound()
}

struct MyParentStruct {
}

// Inheritance from non-protocol type 'MyParentStruct
// struct MyStruct: MyParentStruct {
struct MyStruct {
    var name: String

    var nameTwice: String {
        name + name
    }

    func name(nTimes: Int) -> String {
        var name = ""
        for _ in 0..<nTimes {
            name += self.name
        }
        return name
    }

    mutating func changeName(to newName: String) {
        name = newName
    }
}

let myClass1 = Human()
let myClass2 = myClass1
myClass1.name = "Aqle"
print(myClass2.name)
var myStruct1 = MyStruct(name: "myStruct1")
var myStruct2 = myStruct1
myStruct1.name = "123"
print(myStruct2.name)

let myStruct3 = MyStruct(name: "123")
print(myStruct3.name(nTimes: 3))
var myStruct4 = MyStruct(name: "123")
print(myStruct4.name)
myStruct4.changeName(to: "234")
print(myStruct4.name)

var myTuple: (String, Int) = ("Amir", 123)
var myTupleWithLabels: (name: String, age: Int) = ("Amir", 111)
myTuple.0
myTuple.1
myTupleWithLabels.name
myTupleWithLabels.age

myTupleWithLabels = myTuple

// Closures

var printNameAndAge: (String, Int) -> Void
printNameAndAge = {
    print("\($0), age: \($1)")
}

printNameAndAge = { name, age in
    var printedTimes: Int = 0
    func updatePrintedTimes() {
        printedTimes += 1
    }
    print("\(name), age: \(age)")
    updatePrintedTimes()
}

class MyPrinter {
    var printer: (String, Int) -> Void = { _, _ in }

    func print(string: String, int: Int) {
        printer(string, int)
    }
}

printNameAndAge("Hello", 1)
printNameAndAge("Hello", 1)
let myPrinter = MyPrinter()
myPrinter.printer = printNameAndAge
printNameAndAge = myPrinter.printer
printNameAndAge("Hello", 1)
printNameAndAge("Hello", 1)
myPrinter.print(string: "A", int: 123)
myPrinter.print(string: "A", int: 123)
myPrinter.print(string: "A", int: 123)

let myView = UIView()
extension UIView: MakingSound {
    func makeSound() {
        print("UIView goes brrrrr")
    }
}
myView.makeSound()
