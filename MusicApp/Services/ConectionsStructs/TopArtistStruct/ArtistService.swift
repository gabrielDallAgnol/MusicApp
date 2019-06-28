//
//  UserService.swift
//  MusicApp
//
//  Created by Palmsoft  on 26/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct ArtistService {
    
    var artistName : String!
    var artistImage : UIImage!
    var artistTopTag : String!
    var artistAlbuns = Array<AlbumService>()
    
    init( artistName : String!, artistTopTag: String!, artistImage : UIImage! ) {
        self.artistName = artistName
        self.artistTopTag = artistTopTag
        self.artistImage = artistImage
    }
}
