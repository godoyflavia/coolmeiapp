//
//  customTableViewCell.swift
//  teste1AddMembros
//
//  Created by Aluno on 26/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personColorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
