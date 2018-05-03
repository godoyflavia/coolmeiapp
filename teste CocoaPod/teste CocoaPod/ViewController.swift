//
//  ViewController.swift
//  teste CocoaPod
//
//  Created by Aluno on 26/04/2018.
//  Copyright © 2018 fem.me. All rights reserved.
//

import UIKit
import PBJHexagon

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionTeste: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionTeste.dataSource = self
        collectionTeste.reloadData()
        
        self.collectionTeste.dataSource = self
        self.collectionTeste.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellTeste = collectionView.dequeueReusableCell(withReuseIdentifier: "celula", for: indexPath) as! TesteCollectionViewCell
        if indexPath.row % 2 == 0 {
            cellTeste.imageTeste.image = UIImage(named: "hexagon.png")
        } else {
            cellTeste.imageTeste.image = UIImage(named: "hexagon-black.png")
            cellTeste.labelTeste.textColor = .white
        }
        
        
        cellTeste.labelTeste.text = "ata"
        
        return cellTeste
    }
    
    // MARK: Delegate Functions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tocou")
    }
    
    
    

}

