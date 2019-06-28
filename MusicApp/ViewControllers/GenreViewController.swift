//
//  GenreViewController.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GenreViewController: UITableViewController, UISearchBarDelegate, UpdateTableView {
    //MARK: - UITILS
    let color = Colors.color
    let font = Fonts.font
    
    //MARK: - SERVICE
    let tableViewService = TableViewService.shared
    
    
    //MARK: - VARIABLES
    var check : Bool!
    
    //MARK: - TOP BAR ITENS
    @IBOutlet weak var SearchOutlet: UIBarButtonItem!
    @IBAction func Search(_ sender: Any) {
        check = !check
        
        if check {
            tableView.reloadData()
        } else {
            TableViewService.shared.genrersAndArtists = DataService.gengersArtists
            tableView.reloadData()
        }
        
    }
    @IBOutlet weak var BackOutlet: UIBarButtonItem!
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - CUSTOM CELL DELEGATE
    func updateTableView() {
        self.tableView.reloadData()
    }
    
    // MARK: - SETUP LAYUOT
    func SetupLayout() {
        let titleTextAttributes =
            [NSAttributedString.Key.foregroundColor:color.quaternaryColor,
             NSAttributedString.Key.font: font.staticBold!]
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        let buttonTextAttributes =
            [NSAttributedString.Key.foregroundColor:color.quinaryColor,
             NSAttributedString.Key.font: font.staticRegular!,
        ]
        SearchOutlet.setTitleTextAttributes(buttonTextAttributes, for: UIControl.State.normal)
        BackOutlet.setTitleTextAttributes(buttonTextAttributes, for: UIControl.State.normal)
        self.tableView.backgroundColor = color.fontColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupLayout()
        check = false
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {return 1}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableViewService.ArtistNumberOfRowsInSection()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchCell
            cell.delegate = self
            if check{ cell.searchBar.becomeFirstResponder()
            } else { cell.searchBar.text = "" }
            return cell}
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "genrer", for: indexPath) as! GenrerCell
            cell.genrer.text = tableViewService.ArtistGenrerForCell(index: indexPath.row)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && check == true {
            return 70
        } else if indexPath.row == 0 && check == false {
            return 0
        } else {
            return 240
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? GenrerCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
}
// MARK: - EXTENSIONS FOR COLLECTION VIEW
extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableViewService.ArtistCollectionnumberOfItemsInSection(tag: collectionView.tag )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artist", for: indexPath) as! ArtistCell
        
        let artistData = tableViewService.ArtistForCollectionCell(tag: collectionView.tag, index: indexPath.item)
        cell.text.text = artistData.artistName
        cell.image.image = artistData.artistImage
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let artistData = tableViewService.ArtistForCollectionCell(tag: collectionView.tag, index: indexPath.item)
        print(artistData.artistAlbuns)
    }
    
    
}
