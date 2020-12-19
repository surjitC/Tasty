//
//  UIButtonExtension.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

extension UIButton {
    func borderedTheme(color: UIColor = .systemYellow, cornerRadius: CGFloat = 8.0) {
        self.setTitleColor(color, for: .normal)
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
    }
    
    func fillTheme(color: UIColor = .systemYellow, cornerRadius: CGFloat = 8.0) {
        self.setTitleColor(.systemBackground, for: .selected)
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
        self.tintColor = .clear
    }
}
