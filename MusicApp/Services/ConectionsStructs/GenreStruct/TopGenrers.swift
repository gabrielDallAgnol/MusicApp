//
//  Gengers.swift
//  MusicApp
//
//  Created by Palmsoft  on 26/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct TopGenrers{
    
    let genrers : [TopGenrer]
    
    init?( json:StructJSON ) {
        guard
            let genrersArray = json["tag"] as? [StructJSON]
            else { return nil }
        
        let genrersObject = genrersArray.map({ TopGenrer(json: $0)! })
        self.genrers = genrersObject
    }
    
}
