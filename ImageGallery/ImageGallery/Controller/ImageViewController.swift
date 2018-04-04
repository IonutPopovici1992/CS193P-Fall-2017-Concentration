//
//  ImageViewController.swift
//  ImageGallery
//
//  Created by John on 3/22/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    weak var transferedImage: UIImage?
    
    var imageView = UIImageView()
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            scrollView?.zoomScale = 1
            imageView.image = newValue
            let size = newValue?.size ?? CGSize.zero
            imageView.frame = CGRect(origin: CGPoint.zero, size: size)
            scrollView?.contentSize = size
            scrollViewWidth?.constant = size.width
            scrollViewHeigth?.constant = size.height
            let safeZoneBounds = UIEdgeInsetsInsetRect(view.bounds, view.safeAreaInsets)
            if size.width >= 0, size.height >= 0 {
                scrollView?.zoomScale = max(safeZoneBounds.width/size.width, safeZoneBounds.height/size.height)
            }
        }
    }
    
    // MARK: ScrollView Layout Constraints
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHeigth: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 5.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    // MARK: Scrollview delegate methods
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewWidth.constant = scrollView.contentSize.width
        scrollViewHeigth.constant = scrollView.contentSize.height
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image = transferedImage
        navigationItem.rightBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
}
