//
//  ViewController.swift
//  teste1AddMembros
//
//  Created by Aluno on 26/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
    var mediadora = Mediadora.shared
    
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
    
    
    @IBOutlet weak var membrosTableView: UITableView!
    
    var membros:[Pessoa] = []
    
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
        
    }
    @IBOutlet weak var corTitulo: UILabel!
    @IBOutlet weak var escolherCor1Outlet: UIButton!
    @IBAction func escolherCor1(_ sender: Any) {
    }
    @IBOutlet weak var escolherCor2Outlet: UIButton!
    @IBAction func escolherCor2(_ sender: Any) {
    }
    @IBOutlet weak var escolherCor3Outlet: UIButton!
    @IBAction func escolherCor3(_ sender: Any) {
    }
    
    @IBOutlet weak var okOutlet: UIButton!
    @IBAction func ok(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        membrosTableView.delegate = self
        membrosTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

