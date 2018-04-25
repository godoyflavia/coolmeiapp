//
//  Classe Tarefa.swift
//  coolmeiappxcode
//
//  Created by Thyago Lacerda on 24/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import Foundation
import UIKit

// as tarefas já vao estar criadas no nosso banco de dados local
// Rita não pode adicionar novas
class TarefaDomestica {
  var nome: String
  var iconeCor: UIImage
  var iconeEscalaCinza: UIImage
  var pontos: Int
  var estaEscolhida: Bool = false // por default começam sem dono
  var quemVaiFazer: String = ""// futuramente ser do tipo "Morador" (a classe das pessoas da casa) e ser inicializado com um Morador "ninguem"
  var estaFeita: Bool = false

  // init padrão pra tarefas
  
  init(nome: String, iconeCor:UIImage, iconeEscalaCinza:UIImage, valor1a5:Int) {
    self.nome = nome
    self.iconeCor = iconeCor
    self.iconeEscalaCinza = iconeEscalaCinza
    self.pontos = valor1a5
  }
  
  // essa função ficaria aqui ou dentro de Morador?
//  func atribuirPontos() {
//    if estaFeita == true {
//      morador.pontuacao = morador.pontuacao + pontos
//    }
//  }
  
}
