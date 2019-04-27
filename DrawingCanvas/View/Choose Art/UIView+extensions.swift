//
//  UIView+extensions.swift
//  DrawingCanvas
//
//  Created by Ashis Laha on 4/26/19.
//  Copyright © 2019 Ashis Laha. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillSuperView(padding: UIEdgeInsets = .zero) { // fill the super view entirely
        anchors(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
    func anchorSize(to view: UIView) {  // create the view exactly same as to view
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchors(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil,  centerX: NSLayoutXAxisAnchor? = nil, centerXConstants: CGFloat = 0.0, centerY: NSLayoutYAxisAnchor? = nil, centerYConstants: CGFloat = 0.0, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        // enable auto-layout for that view
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.height > 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if size.width > 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: centerXConstants).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: centerYConstants).isActive = true
        }
    }
}


