//
//  ViewController.swift
//  teste1AddMembros
//
//  Created by Aluno on 26/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

// TEXTFIELD: SO SALVA O NOME COM O ENTER - AJEITAR

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    let defaults = UserDefaults.standard
    var mediadora = Mediadora.shared
    
    var colorsDictionary:[String:UIColor] = [:]
    
    
    @IBOutlet weak var imagemBotaoSelecionado: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membros.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membrosTableView.dequeueReusableCell(withIdentifier: "customCell") as! customTableViewCell
        cell.personName.text = membros[indexPath.row].nome
        cell.personColorView.backgroundColor = colorsDictionary[membros[indexPath.row].cor]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let pessoa = membros[selectedIndex]
        adicionarPessoa(pessoa)
        inserirNomeOutlet.text! = pessoa.nome
    }
    
    // MARK: - TextField Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            labelText.text = textField.text!
            
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @IBAction func terminou(_ sender: UITextField) {
    }
    
    // MARK: - Outlets and variables
    @IBOutlet weak var membrosTableView: UITableView!
    
    var membros:[Pessoa] = []
    var coresUsadas:[String] = []
    var corEscolhida = ""
    var nomeGenerico = ""
    var escolheuNomeOk = false
    var escolheuCorOk = false
    
    // pop up inicial
    @IBOutlet weak var popUpAddMembros: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var adicionarPessoaOutlet: UIButton!
    @IBAction func adicionarPessoa(_ sender: Any) {
        popUpDPegarInfo.isHidden = false
    }
    @IBOutlet weak var irOutlet: UIButton!
    @IBAction func ir(_ sender: Any) {
        popUpDPegarInfo.isHidden = true
        popUpAddMembros.isHidden = true
    }
    
    // pop up pra cadastrar infos
    @IBOutlet weak var popUpDPegarInfo: UIView!
    @IBOutlet weak var nomeTitulo: UILabel!
    @IBOutlet weak var inserirNomeOutlet: UITextField!
    @IBAction func inserirNome(_ sender: Any) {
        self.nomeGenerico = inserirNomeOutlet.text!
        escolheuNomeOk = true
        if escolheuNomeOk && escolheuCorOk {
            okOutlet.isEnabled = true
        }
    }
    @IBOutlet weak var corTitulo: UILabel!
    @IBOutlet weak var escolherCor1Outlet: UIButton!
    @IBAction func escolherCor1(_ sender: Any) {
        self.corEscolhida = "1"
        coresUsadas.append(self.corEscolhida)
        imagemBotaoSelecionado.isHidden = false
        imagemBotaoSelecionado.frame = CGRect(x: 23, y: 187, width: 50, height: 50)
        escolheuCorOk = true
        if escolheuNomeOk && escolheuCorOk {
            okOutlet.isEnabled = true
        }
    }
    
    @IBOutlet weak var escolherCor2Outlet: UIButton!
    @IBAction func escolherCor2(_ sender: Any) {
        self.corEscolhida = "2"
        coresUsadas.append(self.corEscolhida)
        imagemBotaoSelecionado.isHidden = false
        imagemBotaoSelecionado.frame = CGRect(x: 84, y: 187, width: 50, height: 50)
        escolheuCorOk = true
        if escolheuNomeOk && escolheuCorOk {
            okOutlet.isEnabled = true
        }
    }
    @IBOutlet weak var escolherCor3Outlet: UIButton!
    @IBAction func escolherCor3(_ sender: Any) {
        self.corEscolhida = "3"
        coresUsadas.append(self.corEscolhida)
        imagemBotaoSelecionado.isHidden = false
        imagemBotaoSelecionado.frame = CGRect(x: 147, y: 187, width: 50, height: 50)
        escolheuCorOk = true
        if escolheuNomeOk && escolheuCorOk {
            okOutlet.isEnabled = true
        }
    }
    
    @IBOutlet weak var okOutlet: UIButton!
    @IBAction func ok(_ sender: Any) { // *** limpar o textfield
        membros.append(Pessoa(nome: nomeGenerico, cor: corEscolhida, pontos: 0))
        membrosTableView.reloadData()
        print(corEscolhida)
        
        if membros.count >= 2 {
            irOutlet.isEnabled = true
        }
        
        if membros.count == 6 {
            adicionarPessoaOutlet.isEnabled = false
        }
        
        imagemBotaoSelecionado.isHidden = true
        
        //Botao bloqueado se já foi escolhido
        for cor in corEscolhida {
            if cor == "1" {
                escolherCor1Outlet.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                escolherCor1Outlet.isEnabled = false
            }
            if cor == "2" {
                escolherCor2Outlet.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                escolherCor2Outlet.isEnabled = false
            }
            if cor == "3" {
                escolherCor3Outlet.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                escolherCor3Outlet.isEnabled = false
            }
        }
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: membros)
        UserDefaults.standard.set(encodedData, forKey: "pessoa")
        
        okOutlet.isEnabled = false
        escolheuCorOk = false
        escolheuNomeOk = false
        inserirNomeOutlet.text = ""
        popUpDPegarInfo.isHidden = true
    }
    
    
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        popUpDPegarInfo.isHidden = true
        irOutlet.isEnabled = false
        
        membrosTableView.delegate = self
        membrosTableView.dataSource = self
        inserirNomeOutlet.delegate = self
        
        okOutlet.isEnabled = false
        
        // LEMBRAR DE APLICAR USER DEFAULTS A TABLEVIEW
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            labelText.text = name
        }
        
        if let decoded  = UserDefaults.standard.object(forKey: "pessoa") as? Data {
            let pessoas = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Pessoa]
            labelText.text = pessoas[0].nome
            membros = pessoas
        }
        
        imagemBotaoSelecionado.isHidden = true
        
        colorsDictionary["1"] = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        colorsDictionary["2"] = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        colorsDictionary["3"] = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        colorsDictionary["desativada"] = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        // arredondando botoes de escolha das cores
        escolherCor1Outlet.layer.cornerRadius = 0.5 * escolherCor1Outlet.bounds.size.width
        escolherCor1Outlet.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        escolherCor2Outlet.layer.cornerRadius = 0.5 * escolherCor2Outlet.bounds.size.width
        escolherCor2Outlet.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        escolherCor3Outlet.layer.cornerRadius = 0.5 * escolherCor3Outlet.bounds.size.width
        escolherCor3Outlet.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @objc func hideKeyboard() {
            view.endEditing(true)
        }
}

