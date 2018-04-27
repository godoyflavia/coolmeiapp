//
//  Mediadora.swift
//  teste1AddMembros
//
//  Created by Aluno on 26/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import Foundation

final class Mediadora {
    
    static let shared = Mediadora()
    
    var nomesDasPessoas:[String] = []
    var coresDasPessoas:[String] = []
    
    
    private init() {}
    
}
