import UIKit
import PlaygroundSupport

let size = CGSize(width: 100, height: 100)
let triangleLayer = CAShapeLayer()
triangleLayer.frame = CGRect(origin: .zero, size: size)
// triangleLayer.path // CGPath

let trianglePath = UIBezierPath()
let start = CGPoint(x: 0, y: 0)
trianglePath.move(to: start)
trianglePath.addLine(to: CGPoint(x: 100, y: 0))
trianglePath.addLine(to: CGPoint(x: 50, y: 100))
trianglePath.close()

triangleLayer.path = trianglePath.cgPath
triangleLayer.fillColor = UIColor.blue.cgColor
// triangleLayer.borderColor

let circleLayer = CAShapeLayer()
circleLayer.frame = CGRect(origin: .zero, size: size)
circleLayer.fillColor = UIColor.clear.cgColor
circleLayer.strokeColor = UIColor.blue.cgColor
circleLayer.lineWidth = 10
let circlePath = UIBezierPath()
//let circlePath = UIBezierPath(ovalIn: circleLayer.frame)
circlePath.addArc(
    withCenter: CGPoint(x: 50, y: 50),
    radius: 40,
    startAngle: 0,
    endAngle: 1 * .pi,
    clockwise: true
)
circlePath.stroke()
circleLayer.path = circlePath.cgPath

let view = UIView(frame: CGRect(origin: .zero, size: size))
//view.layer.backgroundColor = UIColor.red.cgColor
//view.layer.addSublayer(triangleLayer)
view.layer.addSublayer(circleLayer)
PlaygroundPage.current.liveView = view

