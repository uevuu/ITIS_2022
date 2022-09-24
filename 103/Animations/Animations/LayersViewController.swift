//
//  LayersViewController.swift
//  Animations
//
//  Created by Amir Zigangarayev on 24.09.2022.
//

import UIKit

class LayersViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
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

        setupLayerAndAnimate()
    }

    private var layer: CALayer = .init()

    private func setupLayerAndAnimate() {
        layer.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        view.layer.addSublayer(layer)

        layer.backgroundColor = UIColor.green.cgColor
        animate()
    }

    private func animate() {
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = layer.backgroundColor
        colorAnimation.toValue = UIColor.red.cgColor
        colorAnimation.duration = 3
        colorAnimation.repeatCount = .infinity
        colorAnimation.autoreverses = true
        let colorKey = "background color animation"
        layer.add(colorAnimation, forKey: colorKey)

        let positionAnimation = CASpringAnimation(keyPath: "position.x")
        positionAnimation.fromValue = CGFloat(50)
        positionAnimation.toValue = CGFloat(75)
        positionAnimation.duration = 0.5
        positionAnimation.repeatCount = .infinity
        positionAnimation.autoreverses = true
        let positionKey = "x animation"
        layer.add(positionAnimation, forKey: positionKey)
    }
}

