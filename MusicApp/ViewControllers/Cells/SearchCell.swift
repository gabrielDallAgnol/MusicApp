//
//  SearchCell.swift
//  MusicApp
//
//  Created by Palmsoft  on 27/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

protocol UpdateTableView: class { // the name of the protocol you can put any
    func updateTableView()
}

class SearchCell: UITableViewCell, UISearchBarDelegate {
    

    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - VARIABLES
    let data = DataService.artists
    var searchActive : Bool = false
    var filteredData: [String]!
    let color = Colors.color
    var input : String!
    
    weak var delegate: UpdateTableView?
    
    // MARK: - AJUST LAYOUT
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = color.fontColor
        searchBar.barTintColor = color.fontColor
        searchBar.placeholder = "Search"
        searchBar.setTextColor(color: color.quaternaryColor)
        searchBar.delegate = self
        filteredData = data
        
        searchBar.reloadInputViews()
    }
    
    // MARK: - SEARCHBAR DEPENDENCIAS
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        input = searchText
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        if searchBar.text == "" {
            TableViewService.shared.genrersAndArtists = DataService.gengersArtists
        } else {
        TableViewService.shared.genrersAndArtists = TableViewService.shared.ParsedGenrersOrdenedByCount(data: filteredData)
        }
        delegate?.updateTableView()
        self.isEditing = true
    }
}

// MARK: - AJUST LAYOUT SEARCHBAR
public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
        tf.textAlignment = .center
        
        let width = self.frame.width / 2 - (tf.attributedPlaceholder?.size().width)!
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .unlessEditing
    }
}

