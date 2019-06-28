//
//  ArtistCell.swift
//  MusicApp
//
//  Created by Palmsoft  on 27/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class ArtistCell: UICollectionViewCell {
    
    let color = Colors.color
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UILabel!
   // MARK: - AJUST LAYOUT
    override func awakeFromNib() {
        text.textColor = color.fontColor
        text.font = UIFont(name: "Static-Bold", size: 15)
        backgroundColor = color.quaternaryColor
        image.layer.cornerRadius = image.frame.width/2
        layer.cornerRadius = frame.height/6
    }
}
