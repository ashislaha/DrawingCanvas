//
//  ChooseArtView.swift
//  DrawingCanvas
//
//  Created by Ashis Laha on 4/26/19.
//  Copyright © 2019 Ashis Laha. All rights reserved.
//

import UIKit

protocol ChooseArtViewDelegate: class {
    func chooseArt(_ image: UIImage)
}

class ChooseArtView: UIView {
    
    private let cellId = "cellId"
    private var collectionView: UICollectionView!
    
    public weak var delegate: ChooseArtViewDelegate?
    public var photos: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewSetUp()
        updatePhotos()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSetUp()
        updatePhotos()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK:- setup collectionView
    private func collectionViewSetUp() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChooseArtViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
    }
    private func updatePhotos() {
        var images: [UIImage] = []
        for i in 0...57 {
            if let image = UIImage(named: "a\(i)") {
                images.append(image)
            }
        }
        photos = images
    }
}

extension ChooseArtView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ChooseArtViewCell else { return UICollectionViewCell() }
        cell.image = photos[indexPath.row]
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension ChooseArtView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.chooseArt(photos[indexPath.row])
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ChooseArtView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3 - 6, height: frame.width/3 - 6)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
