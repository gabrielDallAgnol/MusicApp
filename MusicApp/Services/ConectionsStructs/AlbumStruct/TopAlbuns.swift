//
//  TopAlbuns.swift
//  MusicApp
//
//  Created by Palmsoft  on 28/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation

import UIKit

struct TopAlbuns {
    
    let albuns : [String]
    
    init?( json:StructJSON ) {
        
        guard
            let albunsJSON = json["album"] as? [StructJSON]
            else { return nil}
        
        
        let albunsArray = albunsJSON.map({ TopAlbum(json: $0)?.name }) as? [String]
        
        self.albuns = albunsArray!
    }
    
}
