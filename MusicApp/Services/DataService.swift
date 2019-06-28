//
//  DataService.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias StructJSON = [String: Any]

class DataService {
    
    private init() {}
    // MARK: - VARIABLES
    static let shared = DataService()
    public let conection = Conections()
    static var artistService = Dictionary<String,ArtistService>()
    static var albumService = Dictionary<String,AlbumService>()
    static var gengersArtists = Dictionary<String,[String]>()
    static var gengers = [String]()
    static var artists = [String]()
    
    // MARK: - FUNCTION GET ABLBUM INFO
    func getAlbunsInfo ( artist : String, album: String, completion: @escaping (StructJSON) -> Void ) {
        var artistFixed = artist.stripped
        artistFixed = artistFixed.replacingOccurrences(of: " ", with: "%20")
        var albumFixed = album.stripped
        albumFixed = artistFixed.replacingOccurrences(of: " ", with: "%20")
        AF.request(conection.getAlbumInfo(artist: artistFixed, album: albumFixed)).responseJSON { (response) -> Void in
            switch response.result {
            case let .success(value):
                let json = value as! StructJSON
                
                completion(json)
                break
            case let .failure(error):
                print(error)
                
            }
        }
        
    }
    
    // MARK: - GET TOP ALBUNS FROM ARTIST
    func getTopAlbuns ( artist : String, completion: @escaping (StructJSON) -> Void ) {
        var artistFixed = artist.stripped
        artistFixed = artistFixed.replacingOccurrences(of: " ", with: "%20")
        AF.request(conection.getTopAlbuns(artist: artistFixed)).responseJSON { (response) -> Void in
            switch response.result {
            case let .success(value):
                let json = value as! StructJSON
                
                completion(json)
                break
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // MARK: - GET TOP ARTISTS TAGS
    func getArtistTopTag ( artist : String, completion: @escaping (Bool) -> Void ) {
        var artistFixed = artist.stripped
        artistFixed = artistFixed.replacingOccurrences(of: " ", with: "%20")
        AF.request(conection.getArtistTopTags(artist: artistFixed)).responseJSON { (response) -> Void in
            switch response.result {
            case let .success(value):
                let json = value as! StructJSON
                
                let topArtistTags : TopGenrers! = TopGenrers(json: (json["toptags"] as? StructJSON)!)
                for genrer in topArtistTags.genrers{
                    
                    if Genres.ganres.contains(genrer.genrer.lowercased()) {
                        
                        let artistInfo  = ArtistService(artistName: artist.stripped,
                                                    artistTopTag: genrer.genrer,
                                                    artistImage: LetterImageGenerator.imageWith(name: artist))
                        
                        
                        DataService.artistService.updateValue(artistInfo, forKey: artist)
                        DataService.artists.append(artist)
                        
                        if !DataService.gengersArtists.keys.contains(genrer.genrer.lowercased()){
                            DataService.gengers.append(genrer.genrer.lowercased())
                            DataService.gengersArtists.updateValue([artist], forKey: genrer.genrer.lowercased())
                        } else { DataService.gengersArtists[genrer.genrer.lowercased()]?.append(artist)
                        }
                        break
                    }
                    
                }
                
                completion(true)
                break
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // MARK: - GET TOP ARTISTS
    func getTopArtists ( completion: @escaping (Bool) -> Void ) {
        AF.request(conection.getTopArtists()).responseJSON { (response) -> Void in
            switch response.result {
            case let .success(value):
                let json = value as! StructJSON
                
                let topArtists : TopArtists = TopArtists(json: (json["artists"] as? StructJSON)!)!
                for artist in topArtists.artists {
                    DataService.shared.getArtistTopTag(artist: artist, completion: { (Bool) in
                    })
                }
                completion(true)
                break
                
            case let .failure(error):
                print(error)
                
            }
        }
        
    }
    
}
    
    

