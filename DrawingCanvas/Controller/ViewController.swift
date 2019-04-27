//
//  ViewController.swift
//  DrawingCanvas
//
//  Created by Ashis Laha on 1/16/19.
//  Copyright © 2019 Ashis Laha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let colors: [UIColor] = [.red, .blue, .green, .yellow, .orange, .black, .darkGray, .white, .cyan, .magenta, .orange, .purple, .brown]
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var canvas: CanvasView! {
        didSet {
            canvas.backgroundColor = .clear
        }
    }
    @IBOutlet weak var colorsCollection: UICollectionView! {
        didSet {
            colorsCollection.delegate = self
            colorsCollection.dataSource = self
        }
    }
    @IBOutlet weak var colorsLabel: UILabel!
    
    // topview contains undo, clear and a slider
    // outlets
    @IBOutlet weak var lineWidthSlider: UISlider!
    @IBOutlet weak var clearOutlet: UIButton! {
        didSet {
            clearOutlet.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var undoOutlet: UIButton! {
        didSet {
            undoOutlet.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var themeOutlet: UIButton! {
        didSet {
            themeOutlet.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var artOutlet: UIButton! {
        didSet {
            artOutlet.layer.cornerRadius = 10
        }
    }
    
    // actions
    @IBAction func slide(_ sender: UISlider) {
        canvas.setStrokeWidth(CGFloat(sender.value))
    }
    @IBAction func clearAll(_ sender: UIButton) {
        canvas.clearAll()
        for eachView in view.subviews where eachView is UIImageView {
            eachView.removeFromSuperview()
        }
    }
    @IBAction func undo(_ sender: UIButton) {
        canvas.undo()
    }
    @IBAction func theme(_ sender: UIButton) {
        let actionsheet = UIAlertController(title: "Choose Theme", message: "", preferredStyle: .actionSheet)
        
        let whiteThemeAction = UIAlertAction(title: "White Background", style: .default) { [weak self] (action) in
            self?.view.backgroundColor = .white
        }
        let blackThemeAction = UIAlertAction(title: "Black Background", style: .default) { [weak self] (action) in
            self?.view.backgroundColor = .black
        }
        actionsheet.addAction(whiteThemeAction)
        actionsheet.addAction(blackThemeAction)
        
        if let popoverVC = actionsheet.popoverPresentationController { // iPad
            popoverVC.sourceView = view
            popoverVC.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverVC.permittedArrowDirections = []
        }
        present(actionsheet, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popover" {
            if let destinationVC = segue.destination as? ChooseArtPopOverViewController {
                destinationVC.delegate = self
                destinationVC.popoverPresentationController?.delegate = self
                destinationVC.preferredContentSize = CGSize(width: 320, height: 300)
                destinationVC.popoverPresentationController?.sourceRect = artOutlet.bounds
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.bringSubviewToFront(canvas)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension ViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        canvas.setStrokeColor(color)
        colorsLabel.textColor = color
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        cell.layer.cornerRadius = cell.frame.width / 2
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension ViewController: ChooseArtViewDelegate {
    func chooseArt(_ image: UIImage) {
        canvas.clearAll()
        for eachView in view.subviews where eachView is UIImageView {
            eachView.removeFromSuperview()
        }
        // add
        let imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
        imageView.frame = canvas.frame
        view.sendSubviewToBack(imageView)
    }
}
