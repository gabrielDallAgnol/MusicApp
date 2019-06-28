//
//  AlbumDesc.swift
//  MusicApp
//
//  Created by Palmsoft  on 28/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
struct AlbumDesc {

    let desc : String!
    
    
    init?(json: StructJSON) {
        guard
            let desc = json["published"] as? String
            else {return nil}
        
        self.desc = desc
        
    }
    
}
