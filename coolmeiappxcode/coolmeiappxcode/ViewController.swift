//
//  ViewController.swift
//  coolmeiappxcode
//
//  Created by Aluno on 24/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var domesticTasksCollection: UICollectionView!
  
  
    @IBOutlet weak var PopUpAddMembros: PopUpAddMembros!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
      self.domesticTasksCollection.dataSource = self
      self.domesticTasksCollection.delegate = self
      
      
      
        PopUpAddMembros.labelView.text = "milena é poc"
      // se vc veio aqui tentando descobrir pq o pop-up nao aparece
      // eh pq ele tem q ficar em cima de tudo no storyboard == ser o último dos arquivinhos
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: DataSource da CollectionVIew
extension ViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 12
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell: DomesticTasksCell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! DomesticTasksCell
    
    cell.taskIcon.image = UIImage(named: "hexagon.png")
    
    return cell
  }
  
}


//MARK: Delegate da CollectionView
extension ViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let cell: DomesticTasksCell = collectionView.cellForItem(at: indexPath)
      as! DomesticTasksCell
    
    if cell.taskIcon.image == UIImage(named: "hexagon.png") {
      cell.taskIcon.image = UIImage(named: "hexagon-black.png")
    } else {
      cell.taskIcon.image = UIImage(named: "hexagon.png")
    }
    
    //domesticTasksCollection.reloadData()
    
  }
  
  
}
