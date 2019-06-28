//
//  GenrerCell.swift
//  MusicApp
//
//  Created by Palmsoft  on 27/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class GenrerCell: UITableViewCell {

    let color = Colors.color
    
    @IBOutlet weak var genrer: UILabel!
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    
    // MARK: - SETUP LAYOUT
    override func awakeFromNib() {
        super.awakeFromNib()
        genrer.textColor = color.tertiaryColor
        genrer.font = UIFont (name: "Static-Bold", size: 25)
        genrer.adjustsFontSizeToFitWidth = true
        
        backgroundColor = color.clearColor
        backgroundView?.backgroundColor = color.clearColor
        
        collectionView.backgroundColor = color.clearColor
        collectionView.backgroundView?.backgroundColor = color.clearColor
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
// MARK: - EXTENCION PARA COLLECTION VIEW
extension GenrerCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
