//
//  GroceryView.swift
//  SwiftUIvsUIKit
//
//  Created by Teacher on 15.04.2023.
//

import UIKit
import SwiftUI

class GroceryView: UIView {
    var grocery: Grocery? {
        didSet {
            label.text = grocery?.name
        }
    }

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    private func setup() {
        addSubview(label)
    }

    override func layoutSubviews() {
        label.frame = bounds
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 300, height: 200)
    }
}

struct SwiftUIGroceryView: UIViewRepresentable {
    var grocery: Grocery

    func updateUIView(_ uiView: GroceryView, context: Context) {
        uiView.grocery = grocery
    }

    func makeUIView(context: Context) -> GroceryView {
        let view = GroceryView()
        view.grocery = grocery
        return view
    }
}
