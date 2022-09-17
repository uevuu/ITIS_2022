import UIKit
import PlaygroundSupport
// PlaygroundPage.current.needsIndefiniteExecution = true

let size100 = CGSize(width: 100, height: 100)
let view = UIView()
view.backgroundColor = .blue
view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 600))
PlaygroundPage.current.liveView = view

let layer = view.layer
let squareLayer = CALayer()
squareLayer.frame = CGRect(
    origin: CGPoint(x: 20, y: 120),
    size: size100
)
squareLayer.backgroundColor = UIColor.red.cgColor
layer.addSublayer(squareLayer)

let circleLayer = CALayer()
circleLayer.backgroundColor = UIColor.gray.cgColor
circleLayer.frame = CGRect(
    origin: .zero, size: size100
)
circleLayer.cornerRadius = 50
layer.addSublayer(circleLayer)
circleLayer.frame.origin = CGPoint(
    x: view.center.x
        - circleLayer.frame.width * 0.5,
    y: view.center.y
        - circleLayer.frame.height * 0.5
)

let gradientLayer = CAGradientLayer()
gradientLayer.startPoint = .zero
gradientLayer.endPoint = CGPoint(x: 1, y: 1)
gradientLayer.colors = [
    UIColor.green.cgColor.copy(alpha: 0.5) as Any,
    UIColor.purple.cgColor.copy(alpha: 0.5) as Any,
    UIColor.cyan.cgColor.copy(alpha: 0.5) as Any,
]
gradientLayer.frame = layer.bounds
layer.addSublayer(gradientLayer)

// CALayer, CAGradientLayer
// let textLayer = CATextLayer()
/*
 CATextLayer *label = [[CATextLayer alloc] init];
 [label setFont:@"Helvetica-Bold"];
 [label setFontSize:20];
 [label setFrame:validFrame];
 [label setString:@"Hello"];
 [label setAlignmentMode:kCAAlignmentCenter];
 [label setForegroundColor:[[UIColor whiteColor] CGColor]];
 [layer addSublayer:label];
 */

let shapeLayer = CAShapeLayer()
// shapeLayer.path

