//
//  DemoURLs.swift
//  Cassini
//
//  Created by John on 3/5/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

struct DemoURLs {
    
    static let stanford = Bundle.main.url(forResource: "oval", withExtension: ".jpg")
    
    static var NASA: Dictionary<String, URL> = {
        let NASAURLStrings = [
            "Cassini": "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth": "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn": "https://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String, URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
    
}
