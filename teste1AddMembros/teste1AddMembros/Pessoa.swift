//
//  Pessoa.swift
//  teste1AddMembros
//
//  Created by Aluno on 26/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import Foundation

class Pessoa: NSObject, NSCoding {
    var nome: String
    var cor: String
    var pontos: Int
    
    init (nome: String, cor: String, pontos: Int) {
        self.nome = nome
        self.cor = cor
        self.pontos = pontos
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let nome = aDecoder.decodeObject(forKey: "nome") as! String
        let cor = aDecoder.decodeObject(forKey: "cor") as! String
        let pontos = aDecoder.decodeInteger(forKey: "pontos")
        self.init(nome: nome, cor: cor, pontos: pontos)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(cor, forKey: "cor")
        aCoder.encode(pontos, forKey: "pontos")
    }
}
