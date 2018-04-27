//
//  ViewController.swift
//  teste CocoaPod
//
//  Created by Aluno on 26/04/2018.
//  Copyright © 2018 fem.me. All rights reserved.
//

import UIKit
import PBJHexagon

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionTeste: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionTeste.dataSource = self
        collectionTeste.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellTeste = collectionView.dequeueReusableCell(withReuseIdentifier: "celula", for: indexPath) as! TesteCollectionViewCell
        cellTeste.labelTeste.text = "ata"
        
        return cellTeste
    }
    
    

}

