//
//  ArtistImage.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct Images {
    
    let images : [Image]
    
    init?( json:StructJSON ) {
        guard
            let imageArray = json["image"] as? [StructJSON]
            else { return nil }
        
        let imagesObject = imageArray.map({ Image(json: $0)! })
        
        self.images = imagesObject
    }
    
}
