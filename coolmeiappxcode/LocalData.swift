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
    
    var chosenPeople:[HouseMember] = []
    
    
    // o .name deve se encaixar na frase "who should \(name) today?"
    var allDomesticTasks: [DomesticTask] = [
        DomesticTask(name: "wash the dishes", iconColor: "lavar-pratos.png", value1to5: 2),
        DomesticTask(name: "set the table", iconColor: "botar-mesa.png", value1to5: 1),
        DomesticTask(name: "clear the table", iconColor: "tirar-mesa.png", value1to5: 1),
        DomesticTask(name: "walk the dog", iconColor: "passear-pet.png", value1to5: 2),
        DomesticTask(name: "check expiration dates", iconColor: "checar-validades.png", value1to5: 1),
        DomesticTask(name: "pay the bills", iconColor: "pagar-contas.png", value1to5: 2),
        DomesticTask(name: "make lunch", iconColor: "fazer-almoco.png", value1to5: 3),
        DomesticTask(name: "make dinner", iconColor: "fazer-jantar.png", value1to5: 3),
        DomesticTask(name: "make breakfast", iconColor: "fazer-cafe.png", value1to5: 2),
        DomesticTask(name: "fold the laundry", iconColor: "dobrar-roupa.png", value1to5: 1),
        DomesticTask(name: "do the laundry", iconColor: "lavar-roupa.png", value1to5: 2),
        // DomesticTask(name: "estender as roupas", iconColor: "estender-roupa.png", value1to5: 1),
        DomesticTask(name: "dry the dishes", iconColor: "enxugar-prato.png", value1to5: 1),
        // DomesticTask(name: "guardar os pratos", iconColor: "guardar-prato.png", value1to5: 1),
        // DomesticTask(name: "mop the house", iconColor:  "passar-pano.png", value1to5: 2),   // imagem de pano de mão
        DomesticTask(name: "vacuum the house", iconColor: "aspirar.png", value1to5: 2),
        DomesticTask(name: "buy groceries", iconColor: "fazer-feira.png", value1to5: 4),
        DomesticTask(name: "sweep the house", iconColor: "varrer.png", value1to5: 2),
        DomesticTask(name: "take the kids", iconColor: "levar-filhos.png", value1to5: 3),
        DomesticTask(name: "get the kids", iconColor: "buscar-filhos.png", value1to5: 3)
        
        ] as [DomesticTask]
    
    
    // cores dos moradores
    var colorsDictionary:[String:UIColor] = ["1" : #colorLiteral(red: 0.9294117647, green: 0.4784313725, blue: 0.5647058824, alpha: 1),
                                             "2" : #colorLiteral(red: 0.9490196078, green: 0.6588235294, blue: 0.5568627451, alpha: 1),
                                             "3" : #colorLiteral(red: 0.7294117647, green: 0.5647058824, blue: 0.9568627451, alpha: 1),
                                             "4" : #colorLiteral(red: 0.7490196078, green: 0.6431372549, blue: 0.568627451, alpha: 1),
                                             "5" : #colorLiteral(red: 0.7254901961, green: 0.8823529412, blue: 0.6039215686, alpha: 1),
                                             "6" : #colorLiteral(red: 0.5607843137, green: 0.8666666667, blue: 0.9490196078, alpha: 1),
                                             "deactivated" : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    ]
    
    // array que vai receber os itens selecionados na collectionView do popUp choseTodayTasksPopUpView
    // no botão ok, ele é adicionado ao array da tela principal
    var tasksBeingChosen: [DomesticTask] = []
    
    // array que vai receber as tarefas sendo validadas no popUp de validateTasks
    // no botao ok, ele repassa pra a tela principal as tarefas validadas
    var tasksBeingValidated: [DomesticTask] = []
    
    // eh pra ser inicializado vazio (só testando)
    var membersGettingPoints: [HouseMember] = [
        HouseMember(name: "Rachel", color: "3", points: 13),
        HouseMember(name: "Robert", color: "5", points: 10),
        HouseMember(name: "Theo", color: "2", points: 14),
        HouseMember(name: "Julia", color: "6", points: 11)
        
    ]
    
    
    //em vez de ser uma variável do objeto a ser criado, é uma variável do proprio tipo LocalData
    // acessar com LocalData.shared.houseMembers
    // tipo a classe mediadora de flávia (singleton) (single ailton)
    // o static transforma em singleton: só vai existir uma instância (objeto) ??
    // usada pra assessar esses arrays do lado de fora do struct
    //MARK:
    static let shared = LocalData()
    private init() {}
}


//
// atividades em português
//
//var allDomesticTasks: [DomesticTask] = [
//    DomesticTask(name: "lavar os pratos", iconColor: "lavar-pratos.png", value1to5: 2),
//    DomesticTask(name: "botar a mesa", iconColor: "botar-mesa.png", value1to5: 1),
//    DomesticTask(name: "tirar a mesa", iconColor: "tirar-mesa.png", value1to5: 1),
//    DomesticTask(name: "passear com o cachorro", iconColor: "passear-pet.png", value1to5: 2),
//    DomesticTask(name: "checar validades", iconColor: "checar-validades.png", value1to5: 1),
//    DomesticTask(name: "pagar as contas", iconColor: "pagar-contas.png", value1to5: 2),
//    DomesticTask(name: "fazer o almoço", iconColor: "fazer-almoco.png", value1to5: 3),
//    DomesticTask(name: "fazer o jantar", iconColor: "fazer-jantar.png", value1to5: 3),
//    DomesticTask(name: "fazer café da manhã", iconColor: "fazer-cafe.png", value1to5: 2),
//    DomesticTask(name: "dobrar as roupas", iconColor: "dobrar-roupa.png", value1to5: 1),
//    DomesticTask(name: "lavar roupa", iconColor: "lavar-roupa.png", value1to5: 2),
//    DomesticTask(name: "estender as roupas", iconColor: "estender-roupa.png", value1to5: 1),
//    DomesticTask(name: "enxugar os pratos", iconColor: "enxugar-prato.png", value1to5: 1),
//    DomesticTask(name: "guardar os pratos", iconColor: "guardar-prato.png", value1to5: 1),
//    DomesticTask(name: "passar pano", iconColor:  "passar-pano.png", value1to5: 2),
//    DomesticTask(name: "aspirar a casa", iconColor: "aspirar.png", value1to5: 2),
//    DomesticTask(name: "fazer a feira", iconColor: "fazer-feira.png", value1to5: 4),
//    DomesticTask(name: "varrer a casa", iconColor: "varrer.png", value1to5: 2),
//    DomesticTask(name: "levar os filhos", iconColor: "levar-filhos.png", value1to5: 3),
//    DomesticTask(name: "buscar os filhos", iconColor: "buscar-filhos.png", value1to5: 3)
//
//    ] as [DomesticTask]

