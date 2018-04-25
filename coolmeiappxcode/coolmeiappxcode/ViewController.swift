//
//  ViewController.swift
//  coolmeiappxcode
//
//  Created by Aluno on 24/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var PopUpAddMembros: PopUpAddMembros!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PopUpAddMembros.labelView.text = "milena é poc"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

