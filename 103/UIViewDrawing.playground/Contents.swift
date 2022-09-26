import UIKit
import PlaygroundSupport

let bounds = CGRect(
    origin: .zero,
    size: CGSize(width: 150, height: 400)
)

class CustomView: UIView {
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        context.setStrokeColor(UIColor.red.cgColor)
//        context.setLineWidth(3)
//        context.move(to: CGPoint(x: 20, y: 20))
//        context.addLine(to: CGPoint(x: 50, y: 60))
//        context.addLine(to: CGPoint(x: 20, y: 60))
//        context.closePath()
//        context.strokePath()
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        UIGraphicsBeginImageContextWithOptions(
            bounds.size,
            true,
            window?.screen.scale ?? 2
        )

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(3)
        context.move(to: CGPoint(x: 20, y: 20))
        context.addLine(to: CGPoint(x: 50, y: 60))
        context.addLine(to: CGPoint(x: 20, y: 60))
        context.closePath()
        context.strokePath()

        guard
            let image = UIGraphicsGetImageFromCurrentImageContext()
        else { return }

        let imageView = UIImageView(image: image)
        imageView.frame = bounds
        addSubview(imageView)
    }
}

let view = CustomView(frame: bounds)
PlaygroundPage.current.liveView = view
