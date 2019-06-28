//
//  TableViewService.swift
//  MusicApp
//
//  Created by Palmsoft  on 27/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import UIKit

struct ShortedGenre {
    var genre:String!
    var count:Int!
    
    init(genre:String!, count:Int!){
        self.genre = genre
        self.count = count
    }
}
class TableViewService {
    
    private init() {}
    
    static let shared = TableViewService()
    public var genrersAndArtists = DataService.gengersArtists
    
    
    // MARK: - ORGANIZER GENRERS BY SIZE
    func GenrersOrdenedByCount( genrers : [String : [String]] ) -> Array<ShortedGenre> {
        var array = Array<ShortedGenre>()
        for itens in genrers{
            array.append(ShortedGenre(genre: itens.key, count: itens.value.count))}
        return array.sorted(by: { $0.count > $1.count })
    }
    
    
    // MARK: - ORGANIZER GENRERS PARSED BY SEARCHBAR FILTRO BY SIZE
    func ParsedGenrersOrdenedByCount( data: [String] ) -> [String : [String]] {
        var genrers = Dictionary<String,[String]>()
        for artist in data {
            let parsedArtist = DataService.artistService[artist]
            if !genrers.keys.contains(parsedArtist!.artistTopTag){
                genrers.updateValue([parsedArtist!.artistName], forKey: parsedArtist!.artistTopTag.lowercased())
            } else { genrers[parsedArtist!.artistTopTag.lowercased()]?.append(parsedArtist!.artistName)
            }
        }
        return genrers
        
    }
    
    // MARK: - SETUP THE NUMBER OF ROWS IN TABLEVIEW
    func ArtistNumberOfRowsInSection() -> Int {
        return GenrersOrdenedByCount(genrers: genrersAndArtists).count + 1
    }
    // MARK: - SETUP THE ARTIRST NAME IN TABLEVIEWCELL
    func ArtistGenrerForCell( index:Int ) -> String {
        return GenrersOrdenedByCount(genrers: genrersAndArtists)[index - 1].genre
    }
    // MARK: - SETUP THE NUMBER OF SECTIONS IN COLLETIONVIEW
    func ArtistCollectionnumberOfItemsInSection( tag: Int) -> Int {
        return GenrersOrdenedByCount(genrers: genrersAndArtists)[tag - 1].count
    }
    // MARK: - SETUP THE IMAGE AN ARTIST NAME IN COLLETIONVIEWCELL
    func ArtistForCollectionCell( tag: Int, index: Int) -> ArtistService {
        let genrer = GenrersOrdenedByCount(genrers: genrersAndArtists)[tag - 1].genre!
        let artist = DataService.gengersArtists[genrer]![index]
        return DataService.artistService[artist]!
    }
    
}
