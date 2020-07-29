//
//  LunchDetailsTableViewCell.swift
//  Shubam-People10
//
//  Created by Shubam Gupta on 28/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit

class LunchDetailsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lblRestaurant: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblTwitterHandle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
