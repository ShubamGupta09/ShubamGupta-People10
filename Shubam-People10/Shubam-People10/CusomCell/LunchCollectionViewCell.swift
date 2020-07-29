//
//  LunchCollectionViewCell.swift
//  Shubam-People10
//
//  Created by Shubam Gupta on 28/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit

class LunchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblCategoryType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
