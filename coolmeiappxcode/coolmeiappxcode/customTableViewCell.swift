//
//  customTableViewCell.swift
//  coolmeiappxcode
//
//  Created by Aluno on 02/05/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var memberColor: UIView!
    @IBOutlet weak var memberName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
