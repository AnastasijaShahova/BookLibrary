//
//  StackViewWithExtension.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation
import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews:arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
