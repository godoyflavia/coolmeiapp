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
    
    // gambiarra do desespero: esconder celulas sos
    @IBOutlet weak var gambiarraIndex3: UIView!
    @IBOutlet weak var gambiarraIndex11: UIView!
    @IBOutlet weak var gambiarraIndex19: UIView!
    
    
    // Variables
    var blurEffectView = UIVisualEffectView()
    var nowEditing = false
    var usedColors:[String] = []
    var chosenColor = ""
    var genericName = ""
    var nameWasChosen = false
    var colorWasChosen = false
    
    var memberColorChosen: UIColor!
    
    //MARK: outlets do cabeçalho
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var timeToEndOfDayProgressView: UIProgressView!
    @IBOutlet weak var timeToEndOfDayLabel: UILabel!
    @IBOutlet weak var toTheEndOfDayText: UILabel!
    
    
    //MARK: First popup (add members or go)
    @IBOutlet var addMembersPopUpView: UIView!
    @IBOutlet weak var firstPopUptITitle: UILabel!
    @IBOutlet weak var firstPopUpMembersTableView: UITableView!
    @IBOutlet weak var addMemberOutlet: UIButton!
    @IBAction func addMember(_ sender: Any) {
        collectMemberInfoPopUpView.isHidden = false
    }
    @IBOutlet weak var goOutlet: UIButton!
    @IBAction func go(_ sender: Any) {
        viewMembersPopUpView.isHidden = true
        collectMemberInfoPopUpView.isHidden = true
        addMembersPopUpView.isHidden = true
        closeBlur()
    }
    
    //MARK: Second popup (collect member's information)
    @IBOutlet weak var collectMemberInfoPopUpView: UIView!
    @IBOutlet weak var goBackToFirstOutlet: UIButton!
    @IBAction func goBackToFirst(_ sender: Any) {
        collectMemberInfoPopUpView.isHidden = true
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
    
    // colors buttons
    @IBOutlet weak var chooseColor1Outlet: UIButton!
    @IBOutlet weak var chooseColor2Outlet: UIButton!
    @IBOutlet weak var chooseColor3Outlet: UIButton!
    @IBOutlet weak var chooseColor4Outlet: UIButton!
    @IBOutlet weak var chooseColor5Outlet: UIButton!
    @IBOutlet weak var chooseColor6Outlet: UIButton!
    
    // ok button
    @IBOutlet weak var nameAndColorOkOutlet: UIButton!
    
    
    
    //MARK: Third popup (collect member's information)
    @IBOutlet var viewMembersPopUpView: UIView!
    @IBOutlet weak var titlePopUpLabel: UILabel!
    @IBOutlet weak var membersTableView: UITableView!
    
    
    //MARK: Fourth popup outlet (chose day tasks)
    @IBOutlet weak var choseTodayTasksPopUpView: UIView!
    @IBOutlet weak var tasksToChoseCollection: UICollectionView!
    
    //MARK: Fifth PopUp (delegate tasks)
    @IBOutlet weak var delegateTasksPopUpView: UIView!
    @IBOutlet weak var iconTaskClickedImageView: UIImageView!
    @IBOutlet weak var valueTaskClikedLabel: UILabel!
    @IBOutlet weak var whoWillDoThatLabel: UILabel!
    @IBOutlet weak var membersToChoseTableView: UITableView!
    
    
    //MARK: collection da view tela principal
    @IBOutlet weak var domesticTasksCollection: UICollectionView!

    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // gambiarra esconder celula sos
        gambiarraIndex3.layer.cornerRadius = 0.5 * gambiarraIndex3.bounds.size.width
        gambiarraIndex11.layer.cornerRadius = 0.5 * gambiarraIndex11.bounds.size.width
        gambiarraIndex19.layer.cornerRadius = 0.5 * gambiarraIndex19.bounds.size.width
        
        
        //Blur config for popups
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Decoding
        // precisa vir antes de tudo, se não não atinge a abertura dos popUps
        if let decoded  = UserDefaults.standard.object(forKey: "person") as? Data {
            let people = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [HouseMember]
            localData.houseMembers = people
        }
        
        // First: addMembersPopUpView
        if localData.houseMembers.count == 0 {
            // comente essa linha acima pra testar os 2 1os popups
            openBlur()
            view.addSubview(addMembersPopUpView)
            formatPopUp(addMembersPopUpView, isHidden: false) //////
            goOutlet.isEnabled = false
            goOutlet.isHidden = false
            addMemberOutlet.isHidden = false
            addMemberOutlet.isEnabled = true
        
            // Second: choseColorPopUpView
            view.addSubview(collectMemberInfoPopUpView)
            formatPopUp(collectMemberInfoPopUpView, isHidden: true) /////
            imageSelectedColor.isHidden = true
        } // e essa tbm
        
        
        // os outros popUps não precisam estar aqui!
        // só precisam ser carregados quando o botão/comando que abre eles for clicado
        // la nesse lugar é só colocar
        // view.addSubview(popUp)
        // formatPopUp(popUp, isHidden: false) // função q eu fiz la em baixo que ja tem todas as formatações
        
        
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
        
        
        //do progress view
        timeToEndOfDayProgressView.layer.cornerRadius = 6 // metade da altura
        timeToEndOfDayProgressView.clipsToBounds = true
        timeToEndOfDayProgressView.layer.sublayers![1].cornerRadius = 6
        timeToEndOfDayProgressView.subviews[1].clipsToBounds = true
        timeToEndOfDayProgressView.progress = 0.8
        // self.timeToEndOfDayProgressView.transform = timeToEndOfDayProgressView.transform.scaledBy(x: 1, y: 4)
        // o auto-layout vai se aplicar ao tamanho original dela (height = 3)
        
        
        //da collection view
        self.domesticTasksCollection.dataSource = self
        self.domesticTasksCollection.delegate = self
        
        self.tasksToChoseCollection.dataSource = self
        self.tasksToChoseCollection.delegate = self
        
        //da tableview
        self.firstPopUpMembersTableView.dataSource = self
        self.firstPopUpMembersTableView.delegate = self
        
        self.membersTableView.dataSource = self
        self.membersTableView.delegate = self
        
        self.membersToChoseTableView.dataSource = self
        self.membersToChoseTableView.delegate = self
        

        
        //textfield
        self.insertNameTxtField.delegate = self as? UITextFieldDelegate
        
        // Tap gesture for dismissing Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        collectMemberInfoPopUpView.addGestureRecognizer(tapGesture)
        
        //MARK: flow layout
        let flowLayout: PBJHexagonFlowLayout = domesticTasksCollection.collectionViewLayout as! PBJHexagonFlowLayout
        //flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        //flowLayout.minimumInteritemSpacing = 3
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        self.domesticTasksCollection.setCollectionViewLayout(flowLayout, animated: false)
        
    }  // fim do longo viewDidLoad()
  
}


//MARK: DataSource da CollectionVIew
extension ViewController: UICollectionViewDataSource {
    
    // Number of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfcells = 0
        
        if collectionView == domesticTasksCollection {
            //numberOfcells = localData.chosenDomesticTasks.count
            numberOfcells = 27 // na prática só mostra 22 (3 células invisíveis)
        } else if collectionView == tasksToChoseCollection {
            numberOfcells = localData.allDomesticTasks.count
        }
        
        return numberOfcells
    }
    
    // Cell for Item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == domesticTasksCollection {
            
            let cell: DomesticTaskCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! DomesticTaskCollectionCell
            
            if indexPath.row % 8 == 3 || indexPath.row == 25 {
                // célula invisível nos indexPathes 4, 12, 20, 28, 36.... (a cada 8)
                // a célula não recebe nenhum atributo, e na didSelect, ela tbm não pode ser clicada
                // nada acontece feijoada
            } else if indexPath.row == 9 {
                // o caso 9 é pra mostrar o botão de add
                cell.taskIcon.image = UIImage(named: "add-task.png")
            } else if indexPath.row == 24 {
                // share (ultima celula)
                // if localData.chosenDomesticTasks.count == 0 {
                    // cell.taskIcon.image = UIImage(named: "share-not-enabled.png")
                // } else {
                    cell.taskIcon.image = UIImage(named: "share.png")
                // }
            } else if indexPath.row == 26 {
                // verificar atividades
                cell.taskIcon.image = UIImage(named: "verify-tasks.png")
            } else {
                if indexPath.row < localData.chosenDomesticTasks.count {
                cell.taskIcon.image = localData.chosenDomesticTasks[indexPath.row].icon
                } else {
                    // celulas invisiveis
                    // cell.taskIcon.image = UIImage(named: "hexagon.png")
                }
            }
            
            return cell
            
        } else { // if collectionView == tasksToChoseCollection
        
            let cell: ChoseTaskCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newTaskCell", for: indexPath) as! ChoseTaskCollectionCell
            cell.taskIconImageView.image = localData.allDomesticTasks[indexPath.row].icon
            cell.taskNameLabel.text = localData.allDomesticTasks[indexPath.row].name
            cell.taskValueLabel.text = String(localData.allDomesticTasks[indexPath.row].value)
            // cell.isOpaque = true
            return cell
        }
        
    }
    
}


//MARK: Delegate da CollectionView
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == domesticTasksCollection {
            let cell: DomesticTaskCollectionCell = collectionView.cellForItem(at: indexPath)
                as! DomesticTaskCollectionCell
            
            // não atinge as células invisíveis (pq não tem else sem condição)
            // ops agr atinge kkkk nao toque nelas!! // resolvido!!!
            if cell.taskIcon.image == UIImage(named: "hexagon.png") {
                cell.taskIcon.image = UIImage(named: "hexagon-black-vert.png")
            } else if cell.taskIcon.image == UIImage(named: "hexagon-black-vert.png") {
                cell.taskIcon.image = UIImage(named: "hexagon.png")
            } else if cell.taskIcon.image == UIImage(named: "add-task.png") {
                // abrir popUp de add tarefa!!
                openBlur()
                view.addSubview(choseTodayTasksPopUpView)
                formatPopUp(choseTodayTasksPopUpView, isHidden: false)
                print("ui, adicionei!")
            } else if cell.taskIcon.image == UIImage(named: "verify-tasks.png") {
                // abrir popUp de verificar tarefas
                print("ui, verifiquei!")
            } else if cell.taskIcon.image == UIImage(named: "share.png") {
                // sharing activities
                let activityVC = UIActivityViewController(activityItems: ["veja como eu dividi as tarefas!"], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC, animated:  true, completion: nil)
                print("ui, compartilhei!")
            } else if cell.taskIcon.image == nil {
                // nada acontece, celulas invisiveis pfvr nao crashem!!
                print("vc recebeu a maldição da celula invisivel, toque no seu amiguinho mais próximo pra repassar")
            } else { //pra as células com atividades ja adicionadas
                // abre o popUp de escolher quem vai fazer
                openBlur()
                view.addSubview(delegateTasksPopUpView)
                formatPopUp(delegateTasksPopUpView, isHidden: false)
                
                // alimentar o header do popUp (se aproveitando do indexPath)
                iconTaskClickedImageView.image = localData.chosenDomesticTasks[indexPath.row].icon
                valueTaskClikedLabel.text = String(localData.chosenDomesticTasks[indexPath.row].value)
                
                let taskName = localData.chosenDomesticTasks[indexPath.row].name
                whoWillDoThatLabel.text = "quem vai \(taskName)?"
                
                print("ui, deleguei")
            }
            
        } else if collectionView == tasksToChoseCollection {
            
            let cell: ChoseTaskCollectionCell = collectionView.cellForItem(at: indexPath) as! ChoseTaskCollectionCell
            
            cell.layer.cornerRadius = 5
            cell.layer.backgroundColor = #colorLiteral(red: 1, green: 0.862745098, blue: 0.4705882353, alpha: 0.2223447086)
            
            let taskTaped = DomesticTask(
                name: cell.taskNameLabel.text!,
                iconColor: cell.taskIconImageView.image!,
                value1to5: Int(cell.taskValueLabel.text!)!
            
            )
            
            //MARK: BUG CONTAINS (?)
            // essa merda de contains que ficou uma bosta
            // provavelmente o bug ta aqui
            if localData.tasksBeingChosen.contains(where: { $0 == taskTaped }) {
               localData.tasksBeingChosen.remove(at: indexPath.row)
            } else { // se não contêm
                localData.tasksBeingChosen.append(taskTaped)
            }
        
        // domesticTasksCollection.reloadData() //- quando chama reloadData() ele relê o cellForItemAt e refaz as células por ele, ignorando qualquer mudança posterior
        }
    }
    
}

//MARK: TableView DataSource
extension ViewController: UITableViewDataSource {
    
    // igual pra todas > todas as table views são pra house members
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.houseMembers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == firstPopUpMembersTableView {
            
            let cell = firstPopUpMembersTableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as! CustomTableViewCell
            cell.memberName.text = localData.houseMembers[indexPath.row].name
            cell.memberColor.backgroundColor = localData.colorsDictionary[localData.houseMembers[indexPath.row].color]
            cell.memberColor.layer.cornerRadius = 0.5 * cell.memberColor.bounds.size.width
            
            return cell
            
        } else if tableView == membersTableView { // popUp de ver a familia
            
            let cell = membersTableView.dequeueReusableCell(withIdentifier: "2customTableViewCell") as! ViewMembersTableCell
            cell.memberName.text = localData.houseMembers[indexPath.row].name
            cell.memberColorImageView.backgroundColor = localData.colorsDictionary[localData.houseMembers[indexPath.row].color]
            cell.memberColorImageView.layer.cornerRadius = 0.5 * cell.memberColorImageView.bounds.size.width
            cell.memberPoints.text = String(localData.houseMembers[indexPath.row].points)
            
            return cell
            
        } else { // if tableView == membersToChoseTableView // pop up de delegar tarefas
            
            let cell: ChoseMemberToDoTableCell = tableView.dequeueReusableCell(withIdentifier: "membersToChose") as! ChoseMemberToDoTableCell
            cell.memberNameLabel.text = localData.houseMembers[indexPath.row].name
            cell.memberColorView.backgroundColor = localData.colorsDictionary[localData.houseMembers[indexPath.row].color]
            cell.memberColorView.layer.cornerRadius = 0.5 * cell.memberColorView.bounds.size.width
            
            return cell
        }
    }
}

//MARK: TableView Delegate

extension ViewController: UITableViewDelegate {
    
    // pega em todas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
//        tableView.cellForRow(at: [indexPath.row])?.layer.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.262745098, blue: 0.4549019608, alpha: 0.25)
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

//MARK: Blur functions to all PopUps
extension ViewController {
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
}

//MARK: Choosing colors functions
extension ViewController {
    // First Button - Pink
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
    // Second Button - Salmon
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
    // Third Button - Purple
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
    // Fourth Button - Dark Blue
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
    // Fifth Button - Green
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
    // Sixth Button - Light Blue
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
    // Choosing name and color
    @IBAction func nameAndColorOk(_ sender: Any) {
        localData.houseMembers.append(HouseMember(name: insertNameTxtField.text!, color: chosenColor))
        // Saving member
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: localData.houseMembers)
        UserDefaults.standard.set(encodedData, forKey: "person")
        firstPopUpMembersTableView.reloadData()
        membersTableView.reloadData()
        goOutlet.isEnabled = false
        
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
        collectMemberInfoPopUpView.isHidden = true
    }
}



// MARK: Third - PopUp Familia
extension ViewController {
    
    //MARK: abrir
    @IBAction func seeFamily(_ sender: UIButton) {
        openBlur()
        view.addSubview(viewMembersPopUpView)
        formatPopUp(viewMembersPopUpView, isHidden: false)
    }
}


//MARK: Fourth - popUp add tasks
extension ViewController {
    
    // voltar
    @IBAction func goBackFromChooseTasks(_ sender: Any) {
        choseTodayTasksPopUpView.isHidden = true
        closeBlur()
    }
    
    // fechar e add
    @IBAction func addTasksButton(_ sender: Any) {
        localData.chosenDomesticTasks = localData.chosenDomesticTasks + localData.tasksBeingChosen
        // appends
        domesticTasksCollection.reloadData() // chama o data source de novo // BUG
        localData.tasksBeingChosen = [] // zera esse array pra próxima leva
        choseTodayTasksPopUpView.isHidden = true
        closeBlur()
    }
}

//MARK: Fifth - popUp delegate tasks
extension ViewController {
    
    // voltar
    @IBAction func goBackFromDelegatePopUp(_ sender: Any) {
        delegateTasksPopUpView.isHidden = true
        closeBlur()
    }
    
    // fechar e delegar
    @IBAction func delegateTaskButton(_ sender: Any) {
        
        
        // delegar aqui
        
        delegateTasksPopUpView.isHidden = true
        closeBlur()
    }
    
}



//MARK: Pop Ups Formatação (func)
extension ViewController {
    
    // funçãozinha pra evitar a repetição de código nos nossos mil pop ups
    func formatPopUp(_ popUp: UIView, isHidden: Bool) {
        
        let cornerRadius:CGFloat = 8.5
        let shadowOffsetWidth:CGFloat = 0.0
        let shadowOffsetHeight:CGFloat = 5
        let shadowColor:UIColor = UIColor.black
        // let shadowOpacity:Float = 0.5  // sem uso
        
        view.addSubview(popUp)
        popUp.center = view.center
        popUp.layer.cornerRadius = cornerRadius
        popUp.layer.shadowColor = shadowColor.cgColor
        popUp.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        
        if isHidden {
            popUp.isHidden = true
        } else {
            popUp.isHidden = false
        }
    }
}




