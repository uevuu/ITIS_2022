import Darwin

protocol Shape{
    func calcSquare() -> Float
}

struct Square: Shape{
    func calcSquare() -> Float {
        return side1 * side2

    }
    var side1, side2: Float
    
    init(side1: Float, side2: Float){
        self.side1 = side1
        self.side2 = side2
    }
}

struct Triangle: Shape{
    func calcSquare() -> Float {
        return side1 * side2 * sinus
    }
    
    var side1, side2, sinus: Float
    
    init(side1: Float, side2: Float, sinus: Float){
        self.side1 = side1
        self.side2 = side2
        self.sinus = sinus
    }
}
struct Circle: Shape{
    func calcSquare() -> Float {
        return 3.14 * radius * radius
    }
     
    var radius: Float
    
    init(radius: Float){
        self.radius = radius
    }
}


var myCircle = Circle(radius: 10)
var myTriangle = Triangle(side1: 10, side2: 34, sinus: 0.5)
var mySquare = Square(side1: 10, side2: 10)

myCircle.calcSquare()
myTriangle.calcSquare()
mySquare.calcSquare()
