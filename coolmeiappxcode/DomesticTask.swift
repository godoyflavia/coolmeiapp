//
//  Classe Tarefa.swift
//  coolmeiappxcode
//
//  Created by Camila Simões on 24/04/18.
//  Copyright © 2018 fem.me. All rights reserved.
//

import Foundation
import UIKit

// as tarefas já vao estar criadas no nosso banco de dados local
// Rita não pode adicionar novas
class DomesticTask {
  var name: String
  var iconColor: UIImage
  // var iconGreyScale: UIImage
  var value: Int = 0
  var isTaken: Bool = false // por default começam sem dono
  var whoWillDo: String = ""// futuramente ser do tipo "HouseMember" (a classe das pessoas da casa) e ser inicializado com um HouseMember "nobody"
  var isDone: Bool = false

  // init padrão pras tarefas
  
  init(name: String, iconColor:UIImage, value1to5:Int) {
    self.name = name
    self.iconColor = iconColor
    // self.iconGreyScale = iconGreyScale
    self.value = value1to5
  }
  
    // essa função ficaria aqui ou dentro de HouseMember?
    //  func getPoints() {
    //    if isDone == true {
    //      member1.points = member1.points + value
    //    }
    //  }
    
}

// var nobody: HouseMember

extension DomesticTask: Equatable {
    
    static func ==(lhs: DomesticTask, rhs: DomesticTask) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }    
    
}
