
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let size100 = CGSize(width: 100, height: 100)
let view = UIView()
view.backgroundColor = .blue
view.frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 600))
PlaygroundPage.current.liveView = view

let layer = view.layer

let element1 = CALayer()
element1.backgroundColor = UIColor.orange.cgColor
element1.frame = CGRect(
    origin: CGPoint(x: 50, y: 200),
    size: CGSize(width: 150, height: 110)
)
layer.addSublayer(element1)

let element2 = CALayer()
element2.backgroundColor = UIColor.orange.cgColor
element2.frame = CGRect(
    origin: CGPoint(x: 70, y: 310),
    size: CGSize(width: 110, height: 70)
)
layer.addSublayer(element2)

let element3 = CALayer()
element3.backgroundColor = UIColor.orange.cgColor
element3.frame = CGRect(
    origin: CGPoint(x: 90, y: 380),
    size: CGSize(width: 80, height: 50)
)
layer.addSublayer(element3)

let element4 = CALayer()
element4.backgroundColor = UIColor.orange.cgColor
element4.frame = CGRect(
    origin: CGPoint(x: 90, y: 380),
    size: CGSize(width: 80, height: 50)
)
layer.addSublayer(element4)

let element5 = CALayer()
element5.backgroundColor = UIColor.orange.cgColor
element5.frame = CGRect(
    origin: CGPoint(x: 110, y: 430),
    size: CGSize(width: 50, height: 30)
)
layer.addSublayer(element5)

let element6 = CALayer()
element6.backgroundColor = UIColor.orange.cgColor
element6.frame = CGRect(
    origin: CGPoint(x: 130, y: 460),
    size: CGSize(width: 20, height: 20)
)
layer.addSublayer(element6)

let dash1 = CALayer()
dash1.backgroundColor = UIColor.brown.cgColor
dash1.frame = CGRect(
    origin: CGPoint(x: 50, y: 230),
    size: CGSize(width: 50, height: 10)
)
layer.addSublayer(dash1)

let dash2 = CALayer()
dash2.backgroundColor = UIColor.brown.cgColor
dash2.frame = CGRect(
    origin: CGPoint(x: 130, y: 260),
    size: CGSize(width: 70, height: 10)
)
layer.addSublayer(dash2)

let dash3 = CALayer()
dash3.backgroundColor = UIColor.brown.cgColor
dash3.frame = CGRect(
    origin: CGPoint(x: 70, y: 320),
    size: CGSize(width: 30, height: 10)
)
layer.addSublayer(dash3)

let dash4 = CALayer()
dash4.backgroundColor = UIColor.brown.cgColor
dash4.frame = CGRect(
    origin: CGPoint(x: 70, y: 360),
    size: CGSize(width: 40, height: 10)
)
layer.addSublayer(dash4)

let dash5 = CALayer()
dash5.backgroundColor = UIColor.brown.cgColor
dash5.frame = CGRect(
    origin: CGPoint(x: 120, y: 340),
    size: CGSize(width: 50, height: 10)
)
layer.addSublayer(dash5)

let dash6 = CALayer()
dash6.backgroundColor = UIColor.brown.cgColor
dash6.frame = CGRect(
    origin: CGPoint(x: 120, y: 400),
    size: CGSize(width: 40, height: 10)
)
layer.addSublayer(dash6)

let dash7 = CALayer()
dash7.backgroundColor = UIColor.brown.cgColor
dash7.frame = CGRect(
    origin: CGPoint(x: 120, y: 440),
    size: CGSize(width: 20, height: 10)
)
layer.addSublayer(dash7)

let list1 = CALayer()
list1.backgroundColor = UIColor.green.cgColor
list1.frame = CGRect(
    origin: CGPoint(x: 140, y: 123),
    size: CGSize(width: 30, height: 100)
)
list1.cornerRadius = 40
list1.transform = CATransform3DMakeRotation(CGFloat(50 * Double.pi / 180), 0.0, 0.0, 1.0)
layer.addSublayer(list1)

let list2 = CALayer()
list2.backgroundColor = UIColor.green.cgColor
list2.frame = CGRect(
    origin: CGPoint(x: 100, y: 112),
    size: CGSize(width: 30, height: 100)
)
list2.cornerRadius = 40
list2.transform = CATransform3DMakeRotation(CGFloat(340 * Double.pi / 180), 0.0, 0.0, 1.0)
layer.addSublayer(list2)

let smile = CALayer()
smile.backgroundColor = UIColor.yellow.cgColor
smile.frame = CGRect(
    origin: CGPoint(x: 205, y: 300),
    size: CGSize(width: 180, height: 180)
)
smile.cornerRadius = 90
layer.addSublayer(smile)

let eye1 = CALayer()
eye1.backgroundColor = UIColor.black.cgColor
eye1.frame = CGRect(
    origin: CGPoint(x: 240, y: 355),
    size: CGSize(width: 20, height: 20)
)
eye1.cornerRadius = 10
layer.addSublayer(eye1)

let eye2 = CALayer()
eye2.backgroundColor = UIColor.black.cgColor
eye2.frame = CGRect(
    origin: CGPoint(x: 300, y: 355),
    size: CGSize(width: 20, height: 20)
)
eye2.cornerRadius = 10
layer.addSublayer(eye2)

let mouth = CALayer()
mouth.backgroundColor = UIColor.red.cgColor
mouth.frame = CGRect(
    origin: CGPoint(x: 250, y: 400),
    size: CGSize(width: 60, height: 60)
)
mouth.cornerRadius = 30
layer.addSublayer(mouth)

let textLayer = CATextLayer()
textLayer.foregroundColor = UIColor.orange.cgColor
textLayer.frame = CGRect(
    origin: CGPoint(x: 50, y: 50),
    size: CGSize(width: 310, height: 70)
)
textLayer.string = "С днём морковки!"
layer.addSublayer(textLayer)
 

let gradientLayer = CAGradientLayer()
gradientLayer.startPoint = .zero
gradientLayer.endPoint = CGPoint(x: 1, y: 1)
gradientLayer.colors = [
    UIColor.white.cgColor.copy(alpha: 0.5) as Any,
    UIColor.systemIndigo.cgColor.copy(alpha: 0.5) as Any,
]
gradientLayer.frame = layer.bounds
layer.addSublayer(gradientLayer)
