//
//  PointsEarnedTableCell.swift
//  coolmeiappxcode
//
//  Created by Camila Simões on 11/05/2018.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class PointsEarnedTableCell: UITableViewCell {

    @IBOutlet weak var memberColorView: UIView!
    
    @IBOutlet weak var memberNameLabel: UILabel!
    
    @IBOutlet weak var memberPointsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
