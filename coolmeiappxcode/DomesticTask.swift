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
class DomesticTask: NSObject, NSCoding {
  var name: String
  var icon: String
  // var iconGreyScale: UIImage
  var value: Int = 0
  var isTaken: Bool = false // por default começam sem dono
  var taskMemberColor:String = ""
  var whoWillDo: String = ""// futuramente ser do tipo "HouseMember" (a classe das pessoas da casa) e ser inicializado com um HouseMember "nobody"
  var isDone: Bool = false

  // init padrão pras tarefas
  
  init(name: String, iconColor:String, value1to5:Int) {
    self.name = name
    self.icon = iconColor
    // self.iconGreyScale = iconGreyScale
    self.value = value1to5
  }

    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let icon = aDecoder.decodeObject(forKey: "icon") as! String
        let value = aDecoder.decodeInteger(forKey: "value") as Int
        let taskMemberColor = aDecoder.decodeObject(forKey: "taskMemberColor") as! String
        let isDone = aDecoder.decodeBool(forKey: "isDone") as Bool
        self.init(name: name, iconColor: icon, value1to5: value)
        self.taskMemberColor = taskMemberColor
        self.isDone = isDone
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(taskMemberColor, forKey: "taskMemberColor")
        aCoder.encode(isDone, forKey: "isDone")
    }

  
    // essa função ficaria aqui ou dentro de HouseMember?
    //  func getPoints() {
    //    if isDone == true {
    //      member1.points = member1.points + value
    //    }
    //  }
    
}

// var nobody: HouseMember

extension DomesticTask {// : Equatable {
//
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? DomesticTask {
            return self.name == rhs.name
        } else {
            return false
        }
    }
    
//    override static func ==(lhs: DomesticTask, rhs: DomesticTask) -> Bool {
//        if lhs.name == rhs.name {
//            return true
//        } else {
//            return false
//        }
//    }

}
