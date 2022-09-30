import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        NotificationCenter.default.addObserver(
            self, selector: #selector(reanimate),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc func reanimate() {
        animate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animate()
    }
    
    private let label: UILabel = .init()
    private let rightBlock: UIView = .init()
    private let lowerBlock: UIView = .init()
    private let leftBlock: UIView = .init()
    private let gift: CALayer = .init()
    
    private func setup(){
        view.layer.addSublayer(gift)
        view.addSubview(label)
        view.addSubview(leftBlock)
        view.addSubview(lowerBlock)
        view.addSubview(rightBlock)
        
        label.text = "Ты выиграл приз!!!"
        label.textColor = .red
        label.font = .systemFont(ofSize: 30)
        label.sizeToFit()
        label.frame.origin = CGPoint(x: 40, y: 200)
        
        rightBlock.frame = CGRect(x: 234, y: 0, width: 180, height: 0)
        lowerBlock.frame = CGRect(x: 0, y: 896, width: 150, height: 416)
        leftBlock.frame = CGRect(x: 0, y: 0, width: 0, height: 480)
        gift.frame = CGRect(x: 107, y: 348, width: 200, height: 200)
        
        gift.contents = UIImage(named: "gift")?.cgImage
        leftBlock.backgroundColor = .orange
        lowerBlock.backgroundColor = .yellow
        rightBlock.backgroundColor = .red
        view.backgroundColor = .gray
        
        animate()
    }
    

    private func animate() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotationAnimation.duration = 4
        rotationAnimation.repeatCount = .infinity
        let rotationKey = "rotation animation"
        gift.add(rotationAnimation, forKey: rotationKey)
        
        UIView.animate(
            withDuration: 3,
            delay: 0,
            options: [ .repeat, .autoreverse ]
        ) { [self] in
            label.frame.origin.x = 140
        }
        
        UIView.animateKeyframes(
            withDuration: 4,
            delay: 0,
            options: [ .repeat, .autoreverse ]
        ) {[self] in
            UIView.addKeyframe(
                withRelativeStartTime: 0.25, relativeDuration: 1
            ) { [self] in
                leftBlock.frame.size = CGSize(width: 234, height: 480)
                lowerBlock.frame.origin.y = 480
                rightBlock.frame.size = CGSize(width: 180, height: 600)
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0.5, relativeDuration: 1
            ) { [self] in
                lowerBlock.frame.size = CGSize(width: 414, height: 416)
            }
        }
    }
}
