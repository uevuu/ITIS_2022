import UIKit

enum AddressType {
    case country
    case city
    case village
    case street
    case house
    case apartment

    var stringValue: String {
        switch self {
            case .country: return "Country"
            case .city: return "City"
            case .village: return "Village"
            case .street: return "Street"
            case .house: return "House"
            case .apartment: return "Apartment"
        }
    }
}

struct Address {
    var addressParts: [AddressType: String]

    func printDescription() {
        let country = addressParts.first { $0.key == .country }
        let city = addressParts.first { $0.key == .city }
        let street = addressParts.first { $0.key == .street }
        let house = addressParts.first { $0.key == .house }
        let apartment = addressParts.first { $0.key == .apartment }
        [ country, city, street, house, apartment ]
            .compactMap { $0 }
            .forEach { addressType, value in
                print("\(addressType.stringValue): \(value)")
            }
    }

    func validate() -> Bool {
        guard
            addressParts.first(where: { $0.key == .country }) != nil
        else {
            return false
        }

        if let _ = addressParts.first(where: { $0.key == .city }), let _ = addressParts.first(where: { $0.key == .village }) {
            return false
        }

        return true
    }
}

let address = Address(addressParts: [
    .country: "Russia",
    .city: "Kazan",
    .street: "Kremlevskaya",
    .house: "35"
])
address.printDescription()

struct Country {
    let name: String
    let phoneNumberCode: String
}

enum AddressType2 {
    case country(Country)
    case city(String)
}

let firstType: AddressType2 = .country(Country(name: "Russia", phoneNumberCode: "+7"))
let secondType: AddressType2 = .city("Kazan")

switch firstType {
    case .country(let country):
        print("Got country: \(country.name), phone code: \(country.phoneNumberCode)")
    case .city(let city):
        print("Got city: \(city)")
}

switch (firstType, secondType) {
    case (.country(let country1), .country(let country2)):
        print("\(country1.name), \(country2.name)")
    case (.country, .city):
        break
    case (_, .city) where address.addressParts.count > 3:
        break
    default:
        break
}

if case .city = secondType {
    print(secondType)
}

enum SearchError: Error {
    case notFound
}

//enum Optional<Wrapped> {
//    case some(Wrapped)
//    case none
//}

//enum Result<Success, Failure: Error> {
//    case success(Success)
//    case failure(Failure)
//}

func findCity(in address: Address) -> Result<String, SearchError> {
    guard let city = address.addressParts.first(where: { $0.key == .city }) else {
        return .failure(.notFound)
    }

    return .success(city.value)
}

func findCityRequired(in address: Address) -> String {
    let city = address.addressParts.first { $0.key == .city }
    // Такое использовать запрещено женевской конвенцией
    return city!.value
}

func findCityOrEmptyString(in address: Address) -> String {
    let city = address.addressParts.first { $0.key == .city }
    return city?.value ?? ""
}

func findCityOptional(in address: Address) -> String? {
    let city = address.addressParts.first { $0.key == .city }
    return city?.value
}

func findVillage(in address: Address) -> Result<String, SearchError> {
    guard let village = address.addressParts.first(where: { $0.key == .village }) else {
        return .failure(.notFound)
    }

    return .success(village.value)
}

let searchResult1 = findCity(in: address)
print(searchResult1)
let searchResult2 = findVillage(in: address)
print(searchResult2)

// Dispatch
// 1. objc msgSend [object printDescription]; - отсылается сообщение в объект, потом в родитель и тд, пока не упадёт приложение или не будет найден объект, который выполнит эту функцию
// 2. swift vtable - находит объект в виртуальной таблице, вызывает
// 3. static dispatch - есть только одна такая функция, вызывается моментально
// 4. (оптимизация при компиляции) inline - пример ниже
// func fooBar() -> Int { 42 }
// let foo = fooBar()

protocol FooBar {
    func foo()
    func bar()
}

extension FooBar {
    func foo() {
        print("Default \(#function) implementation")
    }
}

class MyFooBarImplementation: FooBar {
    func bar() {
        foo()
    }
}

@objc
protocol FooBarObjC {
    @objc
    optional func foo()

    func bar()
}

class MyFooBarObjCImplementation: FooBarObjC {
    func bar() {
    }
}

class MyFooBarObjCChild: MyFooBarObjCImplementation {
    override func bar() {
        super.bar()
    }
}

class MyViewController: UIViewController {
    let button: UIButton = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    @objc
    private func handleTap() {
    }
}

protocol Hero {
    var health: Int { get set }
}

class Samurai: Hero {
    var health: Int = 500

    func slash(samurai: Samurai) {
        samurai.health -= 100
    }
}

class Ronin: Samurai {
    override func slash(samurai: Samurai) {
        samurai.health -= 150
    }
}

let samurais: [Samurai] = [ Samurai(), Ronin() ]

class Teacher: Hero {
    var health: Int = 100
}

class Group<HeroClass: Hero> {
    var heroes: [HeroClass] = []

    func randomHero() -> HeroClass? {
        heroes.randomElement()
    }
}

extension Group {
    func characterWithMostHp() -> HeroClass? {
        heroes
            .sorted { $0.health > $1.health }
            .first
    }
}

extension Group where HeroClass == Samurai {
    func slash(samurai: Samurai) {
        heroes.forEach { _ in samurai.health -= 100 }
    }
}

let teachersGroup = Group<Teacher>()
let samuraisGroup = Group<Samurai>()
teachersGroup.characterWithMostHp()
samuraisGroup.characterWithMostHp()
// Referencing instance method 'slash(samurai:)' on 'Group' requires the types 'Teacher' and 'Samurai' be equivalent
// teachersGroup.slash(samurai: Samurai())

protocol FooBarBar {
    func sayHello()
}

extension FooBarBar {
    func sayHello() {
        print("Foo Bar Bar")
    }
}

class FooFoo: FooBarBar {
}

class BarBar: FooBarBar {
    func sayHello() {
        print("Bar bar")
    }
}

let barBar1: [any FooBarBar] = [ FooFoo(), BarBar() ]
barBar1.forEach { $0.sayHello() }
let barBar2 = BarBar()
barBar2.sayHello()

// Code style
/*
 class Foo, struct Foo, enum FooBar
 func foo, func fooBar
 var foo, var fooBar

 func fooBar() {
 }

 // Если много переменных, можно засунуть это в структуру
 func fooBar(foo1: Foo1, foo2: Foo2, foo3....) {
 }

 (если параметров 6+)
 struct Foo {
 }
 func fooBar(foo: Foo) {
 }

 // можно переносить строки
 func foo(
     foo1: Foo1, foo2: Foo2, foo1: Foo1, foo2: Foo2,
     foo1: Foo1, foo2: Foo2, foo1: Foo1, foo2: Foo2, foo1: Foo1, foo2: Foo2
 ) -> String {
     // code
 }

 Отступы – 4 пробела
 if / else не должны делать return, если это не конец функции
 Не делать кучу пустых строк подряд, максимум 1 пустая строка
 */
let view = UIView()
let subview = UIView()
view.addSubview(subview)
view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
subview.layer.superlayer
subview.superview

// CALayer
// CAGradientLayer
// CAShapeLayer
