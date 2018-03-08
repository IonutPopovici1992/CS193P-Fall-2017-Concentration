//
//  CassiniViewController.swift
//  Cassini
//
//  Created by John on 3/7/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination.contents as? ImageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
    
}
