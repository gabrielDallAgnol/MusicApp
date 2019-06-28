//
//  ArtistImageType.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct Image {
    
    let size : String
    let url : String
    
    init?(json: StructJSON) {
        guard
            let size = json["size"] as? String,
            let url = json["#text"] as? String
            else {return nil}
        
        self.size = size
        self.url = url
    }
    
}
