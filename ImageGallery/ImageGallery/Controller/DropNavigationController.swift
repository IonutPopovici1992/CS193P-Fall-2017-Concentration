//
//  DropNavigationController.swift
//  ImageGallery
//
//  Created by John on 3/28/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class DropNavigationController: UINavigationController, UIDropInteractionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationBar.addInteraction(UIDropInteraction(delegate: self))
    }
    
    // canHandle
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    // sessionDidUpdate
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
    
    // performDrop
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { (providers) in
            let dropPoint = session.location(in: self.navigationBar)
                // for attributedString in providers as? [NSAttributedString] ?? [] {
                    // self.addLabel(with: attributedString, centeredAt: dropPoint)
                // }
        }
    }

}
