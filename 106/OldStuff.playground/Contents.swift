import UIKit

class MyTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            UIViewController(),
            UIViewController(),
            UIViewController(),
        ]
    }
}

// withDuration - длительность всей анимации
UIView.animateKeyframes(withDuration: 5, delay: 3) {
    // Кейфрейм начнётся через 5*0.5 секунд и продлится 5 * 0.1 секунды
    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
    }
}

/*
 - Не нужно писать пустые функции или классы, наследование нужно, чтобы расширять функционал, речь о пустых viewDidLoad, UITabBarController
 - нужно нормально писать названия классов
 - не нужно оставлять комментарии и пустые линии

 - CGPath, UIBezierPath
 - V-Table, W-Table
 - message dispatch, ооп в диспетчеризация
 - frame/bounds
 - animateKeyframes
 - uiview/calayer
 - implicitly/explicitly unwrapped optional
 - что такое modal presentation, presenting/presented vc
 */
