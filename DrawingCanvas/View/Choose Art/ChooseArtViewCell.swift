//
//  ChooseArtViewCell.swift
//  DrawingCanvas
//
//  Created by Ashis Laha on 4/26/19.
//  Copyright © 2019 Ashis Laha. All rights reserved.
//

import UIKit

class ChooseArtViewCell: UICollectionViewCell {
    
    public var image: UIImage? {
        didSet {
            imageVw.image = image
        }
    }
    
    // view loading
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // clean the collection view cell before reuse
    override func prepareForReuse() {
        imageVw.image = nil
    }
    
    public let imageVw: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: Layout Setup
    private func viewSetup() {
        addSubview(imageVw)
        backgroundColor = .white
        imageVw.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
