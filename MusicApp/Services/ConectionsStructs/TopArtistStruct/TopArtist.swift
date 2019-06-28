//
//  TopArtist.swift
//  MusicApp
//
//  Created by Palmsoft  on 26/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
struct TopArtist {
    
    let name : String!
    
    init?(json: StructJSON) {
        guard
            let name = json["name"] as? String
            else {return nil}
        
        self.name = name
        
    }
    
}
