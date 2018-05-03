//
//  PopUpAddMembros.swift
//  coolmeiappxcode
//
//  Created by Aluno on 24/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class PopUpAddResident: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelView: UILabel!
    
    override init(frame: CGRect) {  // usando a customview no codigo
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // usando na IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PopUpAddResident", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
