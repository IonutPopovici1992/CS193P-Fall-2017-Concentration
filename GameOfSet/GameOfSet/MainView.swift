//
//  MainView.swift
//  GameOfSet
//
//  Created by John on 2/14/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

protocol LayoutViews: class {
    func updateViewFromModel()
}

class MainView: UIView {
    
    weak var delegate: LayoutViews?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        delegate?.updateViewFromModel()
    }
}
