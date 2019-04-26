//
//  ChooseArtPopOverViewController.swift
//  DrawingCanvas
//
//  Created by Ashis Laha on 4/26/19.
//  Copyright © 2019 Ashis Laha. All rights reserved.
//

import UIKit

class ChooseArtPopOverViewController: UIViewController {

    public weak var delegate: ChooseArtViewDelegate?
    
    @IBOutlet weak var artView: ChooseArtView! {
        didSet {
            artView.delegate = self
        }
    }
}

extension ChooseArtPopOverViewController: ChooseArtViewDelegate {
    func chooseArt(_ image: UIImage) {
        delegate?.chooseArt(image)
    }
}
