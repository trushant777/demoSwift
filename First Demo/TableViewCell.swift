//
//  TableViewCell.swift
//  First Demo
//
//  Created by Sarang Jiwane on 24/10/17.
//  Copyright © 2017 com.demo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
