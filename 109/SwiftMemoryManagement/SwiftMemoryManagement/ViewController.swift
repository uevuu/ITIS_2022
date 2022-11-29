//
//  ViewController.swift
//  SwiftMemoryManagement
//
//  Created by Teacher on 05.11.2022.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        let stepper = Stepper()
        stepper.plusTap = { [weak stepper] in
            guard let stepper else { return }

            stepper.set(count: stepper.count + 1)
        }
        stepper.minusTap = { [weak stepper] in
            stepper?.set(count: max(0, (stepper?.count ?? 0) - 1))
        }
        let stepper1 = Stepper()
        let stepper2 = Stepper()
    }

    var lastMapFunction: ((Int) -> String)?

    func doSomething(with array: [Int], map: (Int) -> String) -> [String] {
        var resultArray: [String] = []
        for element in array {
            resultArray.append(map(element))
        }
        return resultArray
    }
}

