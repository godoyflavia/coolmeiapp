//
//  ViewController.swift
//  teste1AddMembros
//
//  Created by Aluno on 26/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    let defaults = UserDefaults.standard
    var mediadora = Mediadora.shared
    
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
        cell.colorImage.image = UIImage(named: membros[indexPath.row].cor)
        cell.personName.text = membros[indexPath.row].nome
        
        return cell
    }
    
    // MARK: - TextField Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            labelText.text = textField.text!
            
         
            
            UserDefaults.standard.set(textField.text, forKey: "name")
            
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @IBAction func terminou(_ sender: UITextField) {
        membros.append(Pessoa(nome: nomeGenerico, cor: "1", pontos: 0))
        print(membros[0].nome)
        membrosTableView.reloadData()
    }
    // MARK: - Outlets and variables
    @IBOutlet weak var membrosTableView: UITableView!
    
    var membros:[Pessoa] = []
    var corEscolhida = ""
    var nomeGenerico = "lalala"
    
    // pop up inicial
    @IBOutlet weak var popUpAddMembros: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var adicionarPessoaOutlet: UIButton!
    @IBAction func adicionarPessoa(_ sender: Any) {
    }
    @IBOutlet weak var irOutlet: UIButton!
    @IBAction func ir(_ sender: Any) {
    }
    
    // pop up pra cadastrar infos
    @IBOutlet weak var popUpDPegarInfo: UIView!
    @IBOutlet weak var nomeTitulo: UILabel!
    @IBOutlet weak var inserirNomeOutlet: UITextField!
    @IBAction func inserirNome(_ sender: Any) {
        self.nomeGenerico = inserirNomeOutlet.text!
    }
    @IBOutlet weak var corTitulo: UILabel!
    @IBOutlet weak var escolherCor1Outlet: UIButton!
    @IBAction func escolherCor1(_ sender: Any) {
        self.corEscolhida = "1"
    }
    @IBOutlet weak var escolherCor2Outlet: UIButton!
    @IBAction func escolherCor2(_ sender: Any) {
        self.corEscolhida = "2"
    }
    @IBOutlet weak var escolherCor3Outlet: UIButton!
    @IBAction func escolherCor3(_ sender: Any) {
        self.corEscolhida = "3"
    }
    
    @IBOutlet weak var okOutlet: UIButton!
    @IBAction func ok(_ sender: Any) {
        membros.append(Pessoa(nome: nomeGenerico, cor: "1", pontos: 0))
         print(membros[0].nome)
    }
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        membrosTableView.delegate = self
        membrosTableView.dataSource = self
        inserirNomeOutlet.delegate = self
        
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            labelText.text = name
        }
        
//        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        popUpDPegarInfo.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
}

