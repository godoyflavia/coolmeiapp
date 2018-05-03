//
//  ViewMembersTableCell.swift
//  coolmeiappxcode
//
//  Created by Aluno on 03/05/2018.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class ViewMembersTableCell: UITableViewCell {
    
    @IBOutlet weak var memberColorImageView: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberPoints: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
