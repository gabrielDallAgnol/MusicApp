//
//  GenrerService.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct TopGenrer {
    
    let genrer : String
    
    init?(json: StructJSON) {
        guard
            let genrer = json["name"] as? String
        
            else {return nil}
        
        self.genrer = genrer
    }
}
