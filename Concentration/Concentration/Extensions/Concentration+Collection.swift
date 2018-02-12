//
//  Concentration+Collection.swift
//  Concentration
//
//  Created by John on 1/29/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

// MARK: Collection extension
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
