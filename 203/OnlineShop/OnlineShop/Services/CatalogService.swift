import Foundation


enum ObtainError: Error {
    case dataIsEmpty
}
enum productType: String{
    case game = "Игры"
    case clothes = "Одежда"
    case car = "Машины"
    case food = "Еда"
}

enum productDecription: String{
    case decription1 = "Этот товар - идеальный выбор для тех, кто ищет универсальный и надежный продукт. Сочетание качественных материалов и стильного дизайна делают его привлекательным и функциональным."
    case decription2 = "Легкий и компактный, этот товар прекрасно подойдет для путешествий и активного отдыха. Высокое качество изготовления гарантирует долговечность и надежность, а эргономичный дизайн обеспечивает комфортное использование."
    case decription3 = "тот товар - отличный выбор для тех, кто ценит стиль и элегантность. Он выполнен из качественных материалов, имеет изысканный дизайн и прекрасно подойдет для повседневного использования или особых случаев."
    case decription4 = "Если вы ищете удобный и функциональный товар для дома или офиса, то это именно то, что вам нужно. Он прост в использовании, легок в уходе и прекрасно справится со своими функциями. Высокое качество и доступная цена делают его отличным выбором."
}

struct Product{
    let name: String
    let decription: productDecription
    let price: Int
    let count: Int
    let type: productType
}

protocol CatalogService {

    func obtainProducts() async throws -> [Product]
}


class MockCatalogService: CatalogService {

    static let shared: MockCatalogService = .init()
    
    func obtainProducts() async throws -> [Product]{
        let products = [Product(name: "Машина 1", decription: .decription1, price: 1_000_000, count: 6, type: .car),
                        Product(name: "Машина 2", decription: .decription2, price: 2_000_000, count: 5, type: .car),
                        Product(name: "Машина 3", decription: .decription3, price: 900_000, count: 2, type: .car),
                        Product(name: "Машина 4", decription: .decription4, price: 1_200_00, count: 3, type: .car),
                        Product(name: "Футболка", decription: .decription1, price: 1_000, count: 123, type: .clothes),
                        Product(name: "Штаны", decription: .decription2, price: 2_000, count: 125, type: .clothes),
                        Product(name: "Куртка", decription: .decription3, price: 5_000, count: 35, type: .clothes),
                        Product(name: "Майка", decription: .decription4, price: 500, count: 23, type: .clothes),
                        Product(name: "Бургер", decription: .decription1, price: 200, count: 23, type: .food),
                        Product(name: "Суши", decription: .decription2, price: 400, count: 12, type: .food),
                        Product(name: "Пицца", decription: .decription3, price: 350, count: 10, type: .food),
                        Product(name: "Шоколадка", decription: .decription4, price: 70, count: 7, type: .food),
                        Product(name: "Монополия", decription: .decription1, price: 2_000, count: 6, type: .game),
                        Product(name: "Гонки", decription: .decription2, price: 3_000, count: 2, type: .game),
                        Product(name: "Шахматы", decription: .decription3, price: 1_500, count: 30, type: .game),
                        Product(name: "Скакалка", decription: .decription4, price: 150, count: 20, type: .game)
        ]
        return products
    }
    
}
