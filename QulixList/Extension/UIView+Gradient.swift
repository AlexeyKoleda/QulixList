//
//  UIView+Gradient.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import UIKit

extension UIView {
    func setGradientBackground(from firstColor: UIColor, to secondColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
