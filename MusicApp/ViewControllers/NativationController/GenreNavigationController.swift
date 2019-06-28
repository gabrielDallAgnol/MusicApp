//
//  GenreViewController.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class GenreNatigationController: UINavigationController, UIViewControllerTransitioningDelegate {

    let color = Colors.color
    let font = Fonts.font
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = color.fontColor
        navigationBar.isTranslucent = false
    
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
