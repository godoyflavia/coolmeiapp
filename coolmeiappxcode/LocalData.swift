//
//  LocalData.swift
//  coolmeiappxcode
//
//  Created by Aluno on 27/04/2018.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import Foundation
import UIKit

// esse struct é nosso banco de dados local
class LocalData {
  
  // se precisar de objetos pra "ninguem"
  var nobody = HouseMember(name: "nobody", color: "1")
  
  //MARK: arrays Banco de Dados
  // array pra alimentar as table views dos moradores
  var houseMembers: [HouseMember] = []

  // array pra alimentar as collection views das tarefas escolhidas por Rita
  var chosenDomesticTasks: [DomesticTask] = []
   
   //
    var allDomesticTasks: [DomesticTask] = [
        DomesticTask(name: "lavar os pratos", iconColor: UIImage(named: "lavar-pratos.png")!, value1to5: 2),
        DomesticTask(name: "botar a mesa", iconColor: UIImage(named: "botar-mesa.png")!, value1to5: 1),
        DomesticTask(name: "tirar a mesa", iconColor: UIImage(named: "tirar-mesa.png")!, value1to5: 1),
        DomesticTask(name: "passear com o cachorro", iconColor: UIImage(named: "passear-pet.png")!, value1to5: 2),
        DomesticTask(name: "checar validades", iconColor: UIImage(named: "checar-validades.png")!, value1to5: 1),
        DomesticTask(name: "pagar as contas", iconColor: UIImage(named: "pagar-contas.png")!, value1to5: 2),
        DomesticTask(name: "fazer o almoço", iconColor: UIImage(named: "fazer-almoco.png")!, value1to5: 3),
        DomesticTask(name: "fazer o jantar", iconColor: UIImage(named: "fazer-jantar.png")!, value1to5: 3),
        DomesticTask(name: "fazer café da manhã", iconColor: UIImage(named: "fazer-cafe.png")!, value1to5: 2),
        DomesticTask(name: "dobrar as roupas", iconColor: UIImage(named: "dobrar-roupa.png")!, value1to5: 1),
        DomesticTask(name: "lavar roupa", iconColor: UIImage(named: "lavar-roupa.png")!, value1to5: 2),
        DomesticTask(name: "estender as roupas", iconColor: UIImage(named: "estender-roupa.png")!, value1to5: 1),
        DomesticTask(name: "enxugar os pratos", iconColor: UIImage(named: "enxugar-prato.png")!, value1to5: 1),
        DomesticTask(name: "guardar os pratos", iconColor: UIImage(named: "guardar-prato.png")!, value1to5: 1),
        DomesticTask(name: "passar pano", iconColor: UIImage(named: "passar-pano.png")!, value1to5: 2),
        DomesticTask(name: "aspirar a casa", iconColor: UIImage(named: "aspirar.png")!, value1to5: 2),
        DomesticTask(name: "fazer a feira", iconColor: UIImage(named: "fazer-feira.png")!, value1to5: 4),
        DomesticTask(name: "varrer a casa", iconColor: UIImage(named: "varrer.png")!, value1to5: 2),
        DomesticTask(name: "levar os filhos", iconColor: UIImage(named: "levar-filhos.png")!, value1to5: 3),
        DomesticTask(name: "buscar os filhos", iconColor: UIImage(named: "buscar-filhos.png")!, value1to5: 3)
        
    ]
    
    
  // cores dos moradores
    var colorsDictionary:[String:UIColor] = ["1" : #colorLiteral(red: 0.9215686275, green: 0.431372549, blue: 0.5019607843, alpha: 1),
                                             "2" : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),
                                             "3" : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                                             "4" : #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),
                                             "5" : #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),
                                             "6" : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
                                             "deactivated" : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    ]
  
    // array que vai receber os itens selecionados na collectionView do popUp choseTodayTasksPopUpView
    // no botão ok, ele é adicionado ao array da tela principal
    var tasksBeingChosen: [DomesticTask] = []
    
    
  //em vez de ser uma variável do objeto a ser criado, é uma variável do proprio tipo LocalData
  // acessar com LocalData.shared.houseMembers
  // tipo a classe mediadora de flávia (singleton) (single ailton)
  // o static transforma em singleton: só vai existir uma instância (objeto) ??
  // usada pra assessar esses arrays do lado de fora do struct
  //MARK:
  static let shared = LocalData()
  private init() {}
}
  

