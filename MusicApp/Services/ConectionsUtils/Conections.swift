//
//  Conections.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

class Conections {
    
    public func getAlbumInfo( artist : String, album : String ) -> String{
        return "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=983f0fad03aafa5d43e928af7e8e53ab&artist=\(artist)&album=\(album)&format=json"
    }
    
    public func getArtistInfo( artist : String ) -> String {
        return "http://ws.audioscrobbler.com/2.0/?format=json&method=artist.getinfo&api_key=983f0fad03aafa5d43e928af7e8e53ab&artist=\(artist)"
    }
    
    public func getTopArtists() -> String {
        return "http://ws.audioscrobbler.com/2.0/?format=json&method=chart.gettopartists&api_key=983f0fad03aafa5d43e928af7e8e53ab&limit=30"
    }
    
    public func getTopAlbuns(artist : String) -> String {
        return "http://ws.audioscrobbler.com/2.0/?format=json&method=artist.gettopalbums&artist=\(artist)&api_key=983f0fad03aafa5d43e928af7e8e53ab"
    }
    
    public func getArtistTopTags(artist : String) -> String {
        return  "http://ws.audioscrobbler.com/2.0/?artist=\(artist)&format=json&method=artist.gettoptags&api_key=983f0fad03aafa5d43e928af7e8e53ab"
    }
}
