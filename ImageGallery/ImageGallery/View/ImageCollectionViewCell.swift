//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by John on 3/28/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    weak var errorHandler: ErrorHandlerForImageGallery?
    
    var url: URL? {
        didSet {
            if url != nil && (oldValue != url) {
                fetchData(imageURL: url!)
            }
        }
    }
    
    private func fetchData(imageURL: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let urlContents = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    if let image = UIImage(data: urlContents) {
                        self?.imageView?.image = image
                        print("ImageView got its data...")
                    } else {
                        self?.errorHandler?.noImageData(for: self!)
                        print("errorHandler was summoned")
                    }
                }
            } else if self != nil {
                DispatchQueue.main.async {
                    self?.errorHandler?.noImageData(for: self!)
                    print("errorHandler was summoned")
                }
            }
        }
    }
    
}
