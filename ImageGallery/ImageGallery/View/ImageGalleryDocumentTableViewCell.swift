//
//  ImageGalleryDocumentTableViewCell.swift
//  ImageGallery
//
//  Created by John on 3/27/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class ImageGalleryDocumentTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.clearsOnBeginEditing = false
            textField.isUserInteractionEnabled = false
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
            tapGestureRecognizer.numberOfTapsRequired = 2
            self.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func onDoubleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            textField.isUserInteractionEnabled = true
            textField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.isUserInteractionEnabled = false
        
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
