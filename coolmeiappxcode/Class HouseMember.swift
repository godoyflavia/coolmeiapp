//
//  Class HouseMember.swift
//  coolmeiappxcode
//
//  Created by Aluno on 27/04/2018.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import Foundation
import UIKit


class HouseMember {
  var name: String
  var color: UIColor
  var points: Int = 0
  var isWinning: Bool = false
  var won: Bool = false
  
  init(name: String, color: UIColor) {
    self.name = name
    self.color = color
  }
  
  
  
}
