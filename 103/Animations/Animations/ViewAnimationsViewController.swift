//
//  ViewAnimationsViewController.swift
//  Animations
//
//  Created by Amir Zigangarayev on 24.09.2022.
//

import UIKit

class ViewAnimationsViewController: UIViewController {
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

    private let animatingView: UIView = .init()
    private let label: UILabel = .init()

    private func setup() {
        view.addSubview(animatingView)
        view.backgroundColor = .orange
        animatingView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        animatingView.backgroundColor = .blue

        view.addSubview(label)
        label.text = "Hello world"
        label.font = .systemFont(ofSize: 70)
        label.sizeToFit()
        label.frame.origin = CGPoint(x: 50, y: 30)
    }

    private func animate() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [ .repeat, .autoreverse ]
        ) { [self] in
            label.frame.origin.x = 40
        }

        UIView.animateKeyframes(
            withDuration: 5,
            delay: 0,
            options: [ .repeat, .autoreverse ]
        ) { [self] in
            UIView.addKeyframe(
                withRelativeStartTime: 0, relativeDuration: 0.5
            ) { [self] in
                animatingView.backgroundColor = .magenta
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0.25, relativeDuration: 0.25
            ) { [self] in
                animatingView.frame.origin.y = 100
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0.5, relativeDuration: 0.25
            ) { [self] in
                animatingView.frame.origin.y = 150
                animatingView.frame.size = CGSize(width: 200, height: 200)
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0.75, relativeDuration: 0.25
            ) { [self] in
                animatingView.frame.size = CGSize(width: 300, height: 300)
            }
        }
    }
}
