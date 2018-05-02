//
//  ViewController.swift
//  coolmeiappxcode
//
//  Created by Flávia Godoy on 24/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit
import PBJHexagon

class ViewController: UIViewController {
  
  //MARK: outlets do cabeçalho
  @IBOutlet weak var familiaButton: UIButton! // dar um refactor depois pra um nome melhor
  @IBOutlet weak var timeToEndOfDayProgressView: UIProgressView!
  @IBOutlet weak var timeToEndOfDayLabel: UILabel!
  @IBOutlet weak var toTheEndOfDayText: UILabel!
  
  
  //MARK: collection da view tela principal
  @IBOutlet weak var domesticTasksCollection: UICollectionView!
  
  //MARK: Pop Ups (11)
  @IBOutlet weak var PopUpAddMembros: PopUpAddMembros!
  
  
  //MARK: viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //do progress view
    timeToEndOfDayProgressView.layer.cornerRadius = 6 // metade da altura
    timeToEndOfDayProgressView.clipsToBounds = true
    timeToEndOfDayProgressView.layer.sublayers![1].cornerRadius = 6
    timeToEndOfDayProgressView.subviews[1].clipsToBounds = true
    // self.timeToEndOfDayProgressView.transform = timeToEndOfDayProgressView.transform.scaledBy(x: 1, y: 4)
    // o auto-layout vai se aplicar ao tamanho original dela (height = 3)
    
    
    //da collection view
    self.domesticTasksCollection.dataSource = self
    self.domesticTasksCollection.delegate = self
    
    //MARK: flow layout
    let flowLayout: PBJHexagonFlowLayout = domesticTasksCollection.collectionViewLayout as! PBJHexagonFlowLayout
    //flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
    //flowLayout.minimumInteritemSpacing = 3
    flowLayout.itemSize = CGSize(width: 80, height: 80)
    // flowLayout.itemsPerRow - nao existe
    //flowLayout.itemsPerRow = 4
    self.domesticTasksCollection.setCollectionViewLayout(flowLayout, animated: false)

    // abre o pop-up de add membros na 1a vez que o app é aberto
    // colocar pra não abrir sempre depois
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
    return 27 // na prática só mostra 22 (3 células invisíveis)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell: DomesticTasksCell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! DomesticTasksCell
    
    if indexPath.row % 8 == 3 || indexPath.row == 25 {
       // célula invisível nos indexPathes 4, 12, 20, 28, 36.... (a cada 8)
       // a célula não recebe nenhum atributo, e na didSelect, ela tbm não pode ser clicada
       // nada acontece feijoada
    } else if indexPath.row == 9 {
       // o caso 9 é pra mostrar o botão de add
       cell.taskIcon.image = UIImage(named: "add-task.png")
    } else if indexPath.row == 24 {
      // verificar atividades
      cell.taskIcon.image = UIImage(named: "verify-tasks.png")
    } else if indexPath.row == 26 {
      // share (ultima celula)
      cell.taskIcon.image = UIImage(named: "share.png")
    } else {
       cell.taskIcon.image = UIImage(named: "hexagon.png")
    }
    return cell
  }
  
}


//MARK: Delegate da CollectionView
extension ViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let cell: DomesticTasksCell = collectionView.cellForItem(at: indexPath)
      as! DomesticTasksCell
    
    // não atinge as células invisíveis (pq não tem else sem condição)
    if cell.taskIcon.image == UIImage(named: "hexagon.png") {
      cell.taskIcon.image = UIImage(named: "hexagon-black-vert.png")
    } else if cell.taskIcon.image == UIImage(named: "hexagon-black-vert.png") {
      cell.taskIcon.image = UIImage(named: "hexagon.png")
    } else if cell.taskIcon.image == UIImage(named: "add-task.png") {
      // abrir popUp de add tarefa!!
      print("ui, adicionei!")
    } else if cell.taskIcon.image == UIImage(named: "verify-tasks.png") {
      // abrir popUp de verificar tarefas
      print("ui, verifiquei!")
    } else if cell.taskIcon.image == UIImage(named: "share.png") {
      // fazer o negocio la de share com os apps (Anna)
      print("ui, compartilhei!")
    }
    
    //domesticTasksCollection.reloadData() - quando chama reloadData() ele relê o cellForItemAt e refaz as células por ele, ignorando qualquer mudança posterior
  }
  
}
