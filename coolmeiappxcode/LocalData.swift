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

  // array pra alimentar as collection views das tarefas
  var domesticTasks: [DomesticTask] = []
  
  
  //em vez de ser uma variável do objeto a ser criado, é uma variável do proprio tipo LocalData
  // acessar com LocalData.shared.houseMembers
  // tipo a classe mediadora de flávia (singleton) (single ailton)
  // o static transforma em singleton: só vai existir uma instância (objeto) ??
  // usada pra assessar esses arrays do lado de fora do struct
  //MARK:
  static let shared = LocalData()
  private init() {}
}
  

