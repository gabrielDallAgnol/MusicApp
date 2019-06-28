//
//  Artist.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct TopArtists {
    
    let artists : [String]
    
    init?( json:StructJSON ) {
        
        guard
            let artistJSON = json["artist"] as? [StructJSON]
            else { return nil}
        
        
        let artistsArray = artistJSON.map({ TopArtist(json: $0)?.name }) as? [String]
        
        self.artists = artistsArray!
    }
    
}
