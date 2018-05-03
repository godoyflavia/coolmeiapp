//
//  ViewController.swift
//  coolmeiappxcode
//
//  Created by Flávia Godoy on 24/04/18.
//  Copyright © 2018 Fem.me. All rights reserved.
//

import UIKit
import PBJHexagon

class ViewController: UIViewController {
    
    var localData = LocalData.shared
    
    var colorsDictionary:[String:UIColor] = [:]
    
    var blurEffectView = UIVisualEffectView()
    func openBlur() {
        view.addSubview(blurEffectView)
        blurEffectView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.blurEffectView.alpha = 1
            })
    }
    
    func closeBlur() {
        blurEffectView.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.blurEffectView.alpha = 0
        }, completion: {(finished: Bool) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    var nowEditing = false
    
    var usedColors:[String] = []
    var chosenColor = ""
    var genericName = ""
    var nameWasChosen = false
    var colorWasChosen = false
    
    //MARK: outlets do cabeçalho
    @IBOutlet weak var familiaButton: UIButton! // dar um refactor depois pra um nome melhor
    @IBOutlet weak var timeToEndOfDayProgressView: UIProgressView!
    @IBOutlet weak var timeToEndOfDayLabel: UILabel!
    @IBOutlet weak var toTheEndOfDayText: UILabel!
    
    // Popups configs
    var cornerRadius:CGFloat = 8.5
    var shadowOffsetWidth:CGFloat = 0.0
    var shadowOffsetHeight:CGFloat = 5
    var shadowColor:UIColor = UIColor.black
    var shadowOpacity:Float = 0.5
    
    //MARK: First popup (add members or go)
    @IBOutlet var firstPopUpView: UIView!
    @IBOutlet weak var firstPopUptITitle: UILabel!
    @IBOutlet weak var firstPopUpMembersTableView: UITableView!
    @IBOutlet weak var addMemberOutlet: UIButton!
    @IBAction func addMember(_ sender: Any) {
        secondPopUpView.isHidden = false
    }
    @IBOutlet weak var goOutlet: UIButton!
    @IBAction func go(_ sender: Any) {
        secondPopUpView.isHidden = true
        firstPopUpView.isHidden = true
        closeBlur()
    }
    
    //MARK: Second popup (collect member's information)
    @IBOutlet weak var secondPopUpView: UIView!
    @IBOutlet weak var goBackToFirstOutlet: UIButton!
    @IBAction func goBackToFirst(_ sender: Any) {
        secondPopUpView.isHidden = true
        insertNameTxtField.text = ""
        imageSelectedColor.isHidden = true
    }
    
    @IBOutlet weak var imageSelectedColor: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func insertName(_ sender: Any) {
        self.genericName = insertNameTxtField.text!
        nameWasChosen = true
        if nameWasChosen && colorWasChosen {
            nameAndColorOkOutlet.isEnabled = true
        }
    }
    @IBOutlet weak var insertNameTxtField: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    
    // colors' buttons
    @IBOutlet weak var chooseColor1Outlet: UIButton!
    @IBAction func chooseColor1(_ sender: Any) {
        self.chosenColor = "1"
        usedColors.append(self.chosenColor)
        imageSelectedColor.isHidden = false
        imageSelectedColor.frame = CGRect(x: 17, y: 268, width: 50, height: 50)
        colorWasChosen = true
        if nameWasChosen && colorWasChosen {
            nameAndColorOkOutlet.isEnabled = true
        }
    }
    
    @IBOutlet weak var chooseColor2Outlet: UIButton!
    @IBAction func chooseColor2(_ sender: Any) {
        self.chosenColor = "2"
        usedColors.append(self.chosenColor)
        imageSelectedColor.isHidden = false
        imageSelectedColor.frame = CGRect(x: 116, y: 268, width: 50, height: 50)
        colorWasChosen = true
        if nameWasChosen && colorWasChosen {
            nameAndColorOkOutlet.isEnabled = true
        }
    }
    
    @IBOutlet weak var chooseColor3Outlet: UIButton!
    @IBAction func chooseColor3(_ sender: Any) {
        self.chosenColor = "3"
        usedColors.append(self.chosenColor)
        imageSelectedColor.isHidden = false
        imageSelectedColor.frame = CGRect(x: 218, y: 268, width: 50, height: 50)
        colorWasChosen = true
        if nameWasChosen && colorWasChosen {
            nameAndColorOkOutlet.isEnabled = true
        }
    }
    
    @IBOutlet weak var chooseColor4Outlet: UIButton!
    @IBAction func chooseColor4(_ sender: Any) {
        self.chosenColor = "4"
        usedColors.append(self.chosenColor)
        imageSelectedColor.isHidden = false
        imageSelectedColor.frame = CGRect(x: 17, y: 338, width: 50, height: 50)
        colorWasChosen = true
        if nameWasChosen && colorWasChosen {
            nameAndColorOkOutlet.isEnabled = true
        }
    }
    
    @IBOutlet weak var chooseColor5Outlet: UIButton!
    @IBAction func chooseColor5(_ sender: Any) {
        self.chosenColor = "5"
        usedColors.append(self.chosenColor)
        imageSelectedColor.isHidden = false
        imageSelectedColor.frame = CGRect(x: 116, y: 338, width: 50, height: 50)
        colorWasChosen = true
        if nameWasChosen && colorWasChosen {
            nameAndColorOkOutlet.isEnabled = true
        }
    }
    
    @IBOutlet weak var chooseColor6Outlet: UIButton!
    @IBAction func chooseColor6(_ sender: Any) {
        self.chosenColor = "6"
        usedColors.append(self.chosenColor)
        imageSelectedColor.isHidden = false
        imageSelectedColor.frame = CGRect(x: 218, y: 338, width: 50, height: 50)
        colorWasChosen = true
        if nameWasChosen && colorWasChosen {
            nameAndColorOkOutlet.isEnabled = true
        }
    }
    
    // ok button
    @IBOutlet weak var nameAndColorOkOutlet: UIButton!
    @IBAction func nameAndColorOk(_ sender: Any) {
        localData.houseMembers.append(HouseMember(name: genericName, color: chosenColor))
        // Saving member
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: localData.houseMembers)
        UserDefaults.standard.set(encodedData, forKey: "person")
        firstPopUpMembersTableView.reloadData()
        
        // usedColors.append(self.chosenColor)
        
        if localData.houseMembers.count >= 2 {
            goOutlet.isEnabled = true
        }
        
        if localData.houseMembers.count == 6 {
            addMemberOutlet.isEnabled = false
        }
        
        nameAndColorOkOutlet.isEnabled = false
        colorWasChosen = false
        nameWasChosen = false
        insertNameTxtField.text = ""
        imageSelectedColor.isHidden = true
        secondPopUpView.isHidden = true
    }
    
    
    //MARK: collection da view tela principal
    @IBOutlet weak var domesticTasksCollection: UICollectionView!
    
    //MARK: Pop Ups (11)
    //@IBOutlet weak var PopUpAddMembros: addMembersPopUp!
    
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Blur config for popups
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // First popup
        view.addSubview(firstPopUpView)
        openBlur()
        firstPopUpView.center = view.center
        firstPopUpView.layer.cornerRadius = cornerRadius
        firstPopUpView.layer.shadowColor = shadowColor.cgColor
        firstPopUpView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        goOutlet.isEnabled = false
        goOutlet.isHidden = false
        addMemberOutlet.isHidden = false
        addMemberOutlet.isEnabled = true
        
        // Second popup
        view.addSubview(secondPopUpView)
        secondPopUpView.isHidden = true
        secondPopUpView.center = view.center
        secondPopUpView.layer.cornerRadius = cornerRadius
        secondPopUpView.layer.shadowColor = shadowColor.cgColor
        secondPopUpView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        imageSelectedColor.isHidden = true
        
        // Rounded buttons and colors for Second Popup
        chooseColor1Outlet.layer.cornerRadius = 0.5 * chooseColor1Outlet.bounds.size.width
        chooseColor1Outlet.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.431372549, blue: 0.5019607843, alpha: 1)
        
        chooseColor2Outlet.layer.cornerRadius = 0.5 * chooseColor2Outlet.bounds.size.width
        chooseColor2Outlet.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        chooseColor3Outlet.layer.cornerRadius = 0.5 * chooseColor3Outlet.bounds.size.width
        chooseColor3Outlet.backgroundColor = #colorLiteral(red: 0.7058277924, green: 0.4251030925, blue: 0.9686274529, alpha: 1)
        
        chooseColor4Outlet.layer.cornerRadius = 0.5 * chooseColor4Outlet.bounds.size.width
        chooseColor4Outlet.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        
        chooseColor5Outlet.layer.cornerRadius = 0.5 * chooseColor5Outlet.bounds.size.width
        chooseColor5Outlet.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        chooseColor6Outlet.layer.cornerRadius = 0.5 * chooseColor6Outlet.bounds.size.width
        chooseColor6Outlet.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        // colors dictionary
        colorsDictionary["1"] = #colorLiteral(red: 0.9215686275, green: 0.431372549, blue: 0.5019607843, alpha: 1)
        colorsDictionary["2"] = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        colorsDictionary["3"] = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        colorsDictionary["4"] = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        colorsDictionary["5"] = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        colorsDictionary["6"] = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        colorsDictionary["deactivated"] = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        // Decoding
        if let decoded  = UserDefaults.standard.object(forKey: "person") as? Data {
            let people = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [HouseMember]
            localData.houseMembers = people
        }
        
        //do progress view
        timeToEndOfDayProgressView.layer.cornerRadius = 6 // metade da altura
        timeToEndOfDayProgressView.clipsToBounds = true
        timeToEndOfDayProgressView.layer.sublayers![1].cornerRadius = 6
        timeToEndOfDayProgressView.subviews[1].clipsToBounds = true
        // self.timeToEndOfDayProgressView.transform = timeToEndOfDayProgressView.transform.scaledBy(x: 1, y: 4)
        // o auto-layout vai se aplicar ao tamanho original dela (height = 3)
        
        
        //da collection view
        self.domesticTasksCollection.dataSource = self
        self.domesticTasksCollection.delegate = self
        
        //da tableview
        self.firstPopUpMembersTableView.dataSource = self
        self.firstPopUpMembersTableView.delegate = self
        
        //textfield
        self.insertNameTxtField.delegate = self as? UITextFieldDelegate
        
        // Tap gesture for dismissing Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //MARK: flow layout
        let flowLayout: PBJHexagonFlowLayout = domesticTasksCollection.collectionViewLayout as! PBJHexagonFlowLayout
        //flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        //flowLayout.minimumInteritemSpacing = 3
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        // flowLayout.itemsPerRow - nao existe
        //flowLayout.itemsPerRow = 4
        self.domesticTasksCollection.setCollectionViewLayout(flowLayout, animated: false)
        
        // abre o pop-up de add membros na 1a vez que o app é aberto
        // colocar pra não abrir sempre depois
        // se vc veio aqui tentando descobrir pq o pop-up nao aparece
        // eh pq ele tem q ficar em cima de tudo no storyboard == ser o último dos arquivinhos
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: DataSource da CollectionVIew
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 27 // na prática só mostra 22 (3 células invisíveis)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: DomesticTasksCell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! DomesticTasksCell
        
        if indexPath.row % 8 == 3 || indexPath.row == 25 {
            // célula invisível nos indexPathes 4, 12, 20, 28, 36.... (a cada 8)
            // a célula não recebe nenhum atributo, e na didSelect, ela tbm não pode ser clicada
            // nada acontece feijoada
        } else if indexPath.row == 9 {
            // o caso 9 é pra mostrar o botão de add
            cell.taskIcon.image = UIImage(named: "add-task.png")
        } else if indexPath.row == 24 {
            // verificar atividades
            cell.taskIcon.image = UIImage(named: "verify-tasks.png")
        } else if indexPath.row == 26 {
            // share (ultima celula)
            cell.taskIcon.image = UIImage(named: "share.png")
        } else {
            cell.taskIcon.image = UIImage(named: "hexagon.png")
        }
        return cell
    }
    
}


//MARK: Delegate da CollectionView
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell: DomesticTasksCell = collectionView.cellForItem(at: indexPath)
            as! DomesticTasksCell
        
        // não atinge as células invisíveis (pq não tem else sem condição)
        if cell.taskIcon.image == UIImage(named: "hexagon.png") {
            cell.taskIcon.image = UIImage(named: "hexagon-black-vert.png")
        } else if cell.taskIcon.image == UIImage(named: "hexagon-black-vert.png") {
            cell.taskIcon.image = UIImage(named: "hexagon.png")
        } else if cell.taskIcon.image == UIImage(named: "add-task.png") {
            // abrir popUp de add tarefa!!
            print("ui, adicionei!")
        } else if cell.taskIcon.image == UIImage(named: "verify-tasks.png") {
            // abrir popUp de verificar tarefas
            print("ui, verifiquei!")
        } else if cell.taskIcon.image == UIImage(named: "share.png") {
            // fazer o negocio la de share com os apps (Anna)
            print("ui, compartilhei!")
        }
        
        //domesticTasksCollection.reloadData() - quando chama reloadData() ele relê o cellForItemAt e refaz as células por ele, ignorando qualquer mudança posterior
    }
    
}

//MARK: TableView DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.houseMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = firstPopUpMembersTableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as! CustomTableViewCell
        cell.memberName.text = localData.houseMembers[indexPath.row].name
        cell.memberColor.layer.cornerRadius = 0.5 * cell.memberColor.bounds.size.width
        cell.memberColor.backgroundColor = colorsDictionary[localData.houseMembers[indexPath.row].color]
        return cell
    }
}

//MARK: TableView Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let selectedPerson = localData.houseMembers[selectedIndex]
        addMember(selectedPerson)
        insertNameTxtField.text! = selectedPerson.name
        nowEditing = true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            localData.houseMembers.remove(at: indexPath.row)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: localData.houseMembers)
            UserDefaults.standard.set(encodedData, forKey: "person")
            tableView.reloadData()
        }
    }
}


//MARK: TextField
extension ViewController: UITextViewDelegate {
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            textField.resignFirstResponder()
        }
        return true
    }
}








