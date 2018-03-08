//
//  Cassini+UIViewController.swift
//  Cassini
//
//  Created by John on 3/8/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
