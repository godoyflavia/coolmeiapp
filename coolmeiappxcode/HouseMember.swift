//
//  Class HouseMember.swift
//  coolmeiappxcode
//
//  Created by Aluno on 27/04/2018.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import Foundation
import UIKit


class HouseMember: NSObject, NSCoding {
  //var localData = LocalData.shared
  var name: String
  var color: String
  var points: Int = 0
//  var areYouWinning: Bool = false
//  var won: Bool = false
  
  init(name: String, color: String) {
    self.name = name
    self.color = color
  }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let color = aDecoder.decodeObject(forKey: "color") as! String
        self.init(name: name, color: color)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(color, forKey: "color")
    }
  
  
  //MARK:
  // função que identifica o membro da casa com mais pontos no momento
  // pode ser usada pra colocar a coroinha e tbm dar o premio no fim do dia
  func whoHaveMorePoints (members: [HouseMember]) -> HouseMember {
    
    var index = 0
    var winnerPoints = 0
    var winnerMember: HouseMember = LocalData.shared.nobody
    
    while index < members.count {
      if members[index].points > winnerPoints {
        winnerPoints = members[index].points
        winnerMember = members[index]
      }
      index = index + 1
    }
    
    // vai ser nobody se todos tiverem zero pontos (nunca entra no if)
    return winnerMember
  }
  
  
  // função Booleana > checa se o membro tem mais pontos ou não
  // uso: member1.isWinnig()
  func isWinning () -> Bool {
    if self.whoHaveMorePoints(members: LocalData.shared.houseMembers) == self {
      return true
    }
    return false
  }
  
}



//MARK: Equatable
// conformando a classe HouseMembers com o protocolo Equatable
// objetivo: poder usar comparar os objetos da classe usando == e !=
//extension HouseMember: Equatable {
//  
//  // função puxada pelo protocolo, que ensina o código a comparar os HouseMember's
//  static func == (lhs: HouseMember, rhs: HouseMember) -> Bool {
//    if lhs.name == rhs.name {
//      return true
//    } else {
//      return false
//    }
//  }
//  
//}

