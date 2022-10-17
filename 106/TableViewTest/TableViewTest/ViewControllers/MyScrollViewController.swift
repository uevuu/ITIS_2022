//
//  MyScrollViewController.swift
//  TableViewTest
//
//  Created by Teacher on 15.10.2022.
//

import UIKit

class MyScrollViewController: UIViewController, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        scrollView.frame = view.bounds
    }

    private let scrollView: UIScrollView = .init()

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        // Чтобы выключить inset от safe area
        // scrollView.contentInsetAdjustmentBehavior = .never

        scrollView.delegate = self

        let stackView = UIStackView()
        stackView.axis = .vertical
        for index in 0 ..< 20 {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = """
                Hello, world world world world world world \
                world world world world world world world \
                world world world world world world world \
                world world world world world world world \
                world world world world world world world #\(index)
                """
            stackView.addArrangedSubview(label)
        }

        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        false
    }
}
