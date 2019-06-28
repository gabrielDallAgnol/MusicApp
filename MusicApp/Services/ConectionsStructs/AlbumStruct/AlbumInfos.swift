//
//  AlbumInfo.swift
//  MusicApp
//
//  Created by Palmsoft  on 28/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct AlbumInfos {
    
    let info : [StructJSON]
    
    init?( json:StructJSON ) {
        
        guard
            let albunsJSON = json["album"] as? [StructJSON]
            else { return nil}
        
        
        self.info = albunsJSON
    }
    
}
