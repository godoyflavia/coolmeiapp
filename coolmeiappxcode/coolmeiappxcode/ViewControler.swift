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

    
    // Variables
    var blurEffectView = UIVisualEffectView()
    var usedColors:[String] = []
    var chosenColor = ""
    var genericName = ""
    var nameWasChosen = false
    var colorWasChosen = false
    var okToDelegate = false
    var selectedAddedTask:IndexPath?
    

    var memberColorChosen: UIColor!
    
    var seconds24h : Float = 86400.0
    var seconds : Float = 86400.0
    var timer = Timer()
    var taskToPersonDict:[IndexPath:Int] = [:]
    
    //MARK: outlets da tela principal
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var timeToEndOfDayProgressView: UIProgressView!
    @IBOutlet weak var timeToEndOfDayLabel: UILabel!
    @IBOutlet weak var toTheEndOfDayText: UILabel!
    //collection da view tela principal
    @IBOutlet weak var domesticTasksCollection: UICollectionView!
    
    
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
    
    
    
    //MARK: Third popup Outlets (collect member's information)
    @IBOutlet var viewMembersPopUpView: UIView!
    @IBOutlet weak var titlePopUpLabel: UILabel!
    @IBOutlet weak var membersTableView: UITableView!
    
    //MARK: Fourth popup outlets (choose day's tasks)
    @IBOutlet weak var choseTodayTasksPopUpView: UIView!
    @IBOutlet weak var tasksToChoseCollection: UICollectionView!
    
    //MARK: Fifth PopUp Outlets (delegate tasks)
    @IBOutlet var delegateTasksPopUpView: UIView!
    @IBOutlet weak var iconTaskClickedImageView: UIImageView!
    @IBOutlet weak var valueTaskClickedLabel: UILabel!
    @IBOutlet weak var whoWillDoThatLabel: UILabel!
    @IBOutlet weak var membersToChoseTableView: UITableView!
    
    //MARK: Sixth PopUp Outlets (validate tasks)
    @IBOutlet var validateTasksPopUpView: UIView!
    @IBOutlet weak var tasksToValidateCollection: UICollectionView!
    
    //MARK: Seventh PopUp Outlets (points earned)
    @IBOutlet var saysPointsEarnedPopUpView: UIView!
    @IBOutlet weak var pointsEarnedTableView: UITableView!
    
    //MARK: Eight popUp Outlets (winner)
    @IBOutlet var saysWinnerPopUpView: UIView!
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var awardSuggestionLabel: UILabel!
    
    //MARK: Nineth PopUp Outlets (start new day)
    @IBOutlet var startNewDayPopUpView: UIView!
    
   ///////////////////////////////////////////////////////////////////////////////////////////

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = membersToChoseTableView.indexPathForSelectedRow{
            membersToChoseTableView.deselectRow(at: index, animated: true)
        }
    }
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        
        if let decoded = UserDefaults.standard.object(forKey: "chosenTask") as? Data {
            let chosenTasks = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [DomesticTask]
            localData.chosenDomesticTasks = chosenTasks
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
        // o auto-layout vai se aplicar ao tamanho original dela (height = 3)
        
        
        //das collection views
        self.domesticTasksCollection.dataSource = self
        self.domesticTasksCollection.delegate = self
        
        self.tasksToChoseCollection.dataSource = self
        self.tasksToChoseCollection.delegate = self
        
        self.tasksToValidateCollection.dataSource = self
        self.tasksToValidateCollection.delegate = self
        
        //das tableviews
        self.firstPopUpMembersTableView.dataSource = self
        self.firstPopUpMembersTableView.delegate = self
        
        self.membersTableView.dataSource = self
        self.membersTableView.delegate = self
        
        self.membersToChoseTableView.dataSource = self
        self.membersToChoseTableView.delegate = self
        
        self.pointsEarnedTableView.dataSource = self
        self.pointsEarnedTableView.delegate = self
        

        
        //textfield
        self.insertNameTxtField.delegate = self
        
        // Tap gesture for dismissing Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        collectMemberInfoPopUpView.addGestureRecognizer(tapGesture)
        
        
        //MARK: flow layouts (tela principal e popUp validate)
        let flowLayout: PBJHexagonFlowLayout = domesticTasksCollection.collectionViewLayout as! PBJHexagonFlowLayout
        //flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        //flowLayout.minimumInteritemSpacing = 3
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        self.domesticTasksCollection.setCollectionViewLayout(flowLayout, animated: false)
        
        let validateFlowLayout: PBJHexagonFlowLayout = tasksToValidateCollection.collectionViewLayout as! PBJHexagonFlowLayout
        validateFlowLayout.itemSize = CGSize(width: 60, height: 60)
        flowLayout.minimumInteritemSpacing = 3
        // flowLayout.
        self.tasksToValidateCollection.setCollectionViewLayout(validateFlowLayout, animated: false)
        
        //para progress view rodar
        runTimer()
        
    }  // fim do longo viewDidLoad()
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////



//MARK: TableView DataSource
extension ViewController: UITableViewDataSource {
    
    // igual pra todas > todas as table views são pra house members
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == pointsEarnedTableView {
            // caso especial, onde nao se mostra a familia toda necessariamente
            return localData.membersGettingPoints.count
            
        } else { // todas as outras table views que mostram a familia toda
            return localData.houseMembers.count
        }
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
            
        } else if tableView == membersToChoseTableView { // pop up de delegar tarefas
            
            let cell: ChoseMemberToDoTableCell = tableView.dequeueReusableCell(withIdentifier: "membersToChose") as! ChoseMemberToDoTableCell
            cell.memberNameLabel.text = localData.houseMembers[indexPath.row].name
            cell.memberColorView.backgroundColor = localData.colorsDictionary[localData.houseMembers[indexPath.row].color]
            cell.memberColorView.layer.cornerRadius = 0.5 * cell.memberColorView.bounds.size.width
            
            return cell
            
        } else { // if tableView == pointsEarnedTableView { // pop up de mostrar gotinhas ganhas
            
            let cell: PointsEarnedTableCell = tableView.dequeueReusableCell(withIdentifier: "see-points-cell") as! PointsEarnedTableCell
            
            cell.memberNameLabel.text = localData.membersGettingPoints[indexPath.row].name
            cell.memberColorView.backgroundColor = localData.colorsDictionary[localData.membersGettingPoints[indexPath.row].color]
            cell.memberColorView.layer.cornerRadius = 0.5 * cell.memberColorView.bounds.size.width
            cell.memberPointsLabel.text = String(localData.membersGettingPoints[indexPath.row].points)
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
        
        
        if tableView == firstPopUpMembersTableView {
            let selectedIndex = indexPath.row
            //        tableView.cellForRow(at: [indexPath.row])?.layer.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.262745098, blue: 0.4549019608, alpha: 0.25)
            let selectedPerson = localData.houseMembers[selectedIndex]
            addMember(selectedPerson)
            insertNameTxtField.text! = selectedPerson.name
            
        }
        
        if tableView == membersToChoseTableView {
            let selectedIndex = indexPath.row
            let selectedPersonColor = localData.houseMembers[selectedIndex].color
            
//            let cell = domesticTasksCollection.cellForItem(at: selectedAddedTask!) as! DomesticTaskCollectionCell
//            cell.memberColor.layer.cornerRadius = 0.5 * cell.memberColor.bounds.size.width
//            cell.memberColor.layer.borderWidth = 2
//            cell.memberColor.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            cell.memberColor.backgroundColor = localData.colorsDictionary[selectedPersonColor]
            
            localData.chosenDomesticTasks[selectedAddedTask!.row].taskMemberColor = selectedPersonColor
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: localData.chosenDomesticTasks)
            UserDefaults.standard.set(encodedData, forKey: "chosenTask")
            domesticTasksCollection.reloadData()
            
            print("que")
            print(selectedPersonColor)
            
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == firstPopUpMembersTableView || tableView == membersTableView {
            if editingStyle == UITableViewCellEditingStyle.delete {
                localData.houseMembers.remove(at: indexPath.row)
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: localData.houseMembers)
                UserDefaults.standard.set(encodedData, forKey: "person")
                tableView.reloadData()
            }
                
        }
    }
}


//MARK: DataSource das CollectionViews
extension ViewController: UICollectionViewDataSource {
    
    // Number of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfcells = 0
        
        if collectionView == domesticTasksCollection {
            //numberOfcells = localData.chosenDomesticTasks.count
            numberOfcells = 27 // na prática só mostra 22 (3 células invisíveis)
        } else if collectionView == tasksToChoseCollection {
            numberOfcells = localData.allDomesticTasks.count
        } else if collectionView == tasksToValidateCollection {
            numberOfcells = localData.chosenDomesticTasks.count
        }
        
        return numberOfcells
    }
    
    // Cell for Item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == domesticTasksCollection {
            
            let cell: DomesticTaskCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! DomesticTaskCollectionCell
            
            // Cleaning the cell before using
            cell.memberColor.layer.borderColor = UIColor.clear.cgColor
            cell.memberColor.backgroundColor = .clear
            cell.memberColor.image = nil
            cell.taskIcon.image = nil
            
            if indexPath.row % 8 == 3 || indexPath.row == 25 {
                // célula invisível nos indexPathes 4, 12, 20, 28, 36.... (a cada 8)
                // a célula não recebe nenhum atributo, e na didSelect, ela tbm não pode ser clicada
                // nada acontece feijoada
                cell.taskIcon.image = nil
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
                    cell.taskIcon.image = UIImage(named: localData.chosenDomesticTasks[indexPath.row].icon)
                    
                    // Setting member color for taskMemberColor
                    if localData.chosenDomesticTasks[indexPath.row].taskMemberColor != "" {
                        cell.memberColor.layer.cornerRadius = 0.5 * cell.memberColor.bounds.size.width
                        cell.memberColor.layer.borderWidth = 2
                        cell.memberColor.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        cell.memberColor.backgroundColor = localData.colorsDictionary[localData.chosenDomesticTasks[indexPath.row].taskMemberColor]
                        
                        
                        print(localData.chosenDomesticTasks[indexPath.row].isDone)
                        if localData.chosenDomesticTasks[indexPath.row].isDone == true {
                            cell.memberColor.image = #imageLiteral(resourceName: "ok")
                            
                        }
                        
                    }
                    
                }
            }
            // Array<DomesticTask>
            return cell
            
        } else if collectionView == tasksToChoseCollection {
        
            let cell: ChoseTaskCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newTaskCell", for: indexPath) as! ChoseTaskCollectionCell
            
//            //// Cleaning the cell before using
//            cell.taskIconImageView.image = nil
//            cell.taskNameLabel.text = ""
//            cell.taskValueLabel.text = ""
            
            cell.taskIconImageView.image = UIImage(named: localData.allDomesticTasks[indexPath.row].icon)
            cell.taskNameLabel.text = localData.allDomesticTasks[indexPath.row].name
            cell.taskValueLabel.text = String(localData.allDomesticTasks[indexPath.row].value)
            // cell.isOpaque = true
            return cell
        
        } else { // if collectionView == tasksToValidateCollection
            
            let cell: ValidateTasksCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "validate-cell", for: indexPath) as! ValidateTasksCollectionCell
            
            if indexPath.row % 8 == 3 || indexPath.row == 25 {  // AS ERRADAS
                // célula invisível nos indexPathes 4, 12, 20, 28, 36.... (a cada 8)
                // a célula não recebe nenhum atributo, e na didSelect, ela tbm não pode ser clicada
                // nada acontece feijoada
                cell.taskToValidateIcon.image = nil
            } else if indexPath.row == 9 {  // CENTRO VAZIO
                // esse é o centro, com o botão de ok
                // cell.taskToValidateIcon.image = UIImage(named: "ok.png")
                cell.taskToValidateIcon.image = nil // agora vazio
            } else {  // TAREFAS
                cell.taskToValidateIcon.image = UIImage(named: localData.chosenDomesticTasks[indexPath.row].icon)
                cell.memberToValidateColor.layer.cornerRadius = 0.5 * cell.memberToValidateColor.bounds.size.width
                // cell.memberToValidateColor.layer.backgroundColor = ??
                
                if cell.isValidateCellSelected == true {
                    cell.alpha = 1 // aparece viva  // alfa 1 é opaco
                    

                } else {
                    cell.alpha = 0.6 // aparece morta  // alfa 0 é transparente
                }
                
            }
            return cell
        }
    }
}



//MARK: Delegate da CollectionView
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == domesticTasksCollection  {
            let cell: DomesticTaskCollectionCell = collectionView.cellForItem(at: indexPath)
                as! DomesticTaskCollectionCell
            
            // não atinge as células invisíveis (pq não tem else sem condição)
            // ops agr atinge kkkk nao toque nelas!! // resolvido!!!
            if cell.taskIcon.image == UIImage(named: "add-task.png") {  // ADD BUTTON
                // abrir popUp de add tarefa!!
                openBlur()
                view.addSubview(choseTodayTasksPopUpView)
                formatPopUp(choseTodayTasksPopUpView, isHidden: false)
                print("ui, adicionei!")
                
            } else if cell.taskIcon.image == UIImage(named: "verify-tasks.png") {   // VALIDATE BUTTON
                // abrir popUp de validar tarefas
                openBlur()
                formatPopUp(validateTasksPopUpView, isHidden: false)
                print("ui, verifiquei!")
                
            } else if cell.taskIcon.image == UIImage(named: "share.png") {   // SHARE BUTTON
                // sharing activities
                let activityVC = UIActivityViewController(activityItems: ["veja como eu dividi as tarefas!"], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC, animated:  true, completion: nil)
                print("ui, compartilhei!")
                
            } else if cell.taskIcon.image == nil {   // CELULA VAZIA
                // nada acontece, celulas invisiveis pfvr nao crashem!!
                print("vc recebeu a maldição da celula invisivel, toque no seu amiguinho mais próximo pra repassar")
                
            } else {   // ATIVIDADES DO DIA
                // abre o popUp de escolher quem vai fazer
//                cell.memberColor.backgroundColor = localData.colorsDictionary[selectedPersonColor[indexPath.row]]
                selectedAddedTask = indexPath
                openBlur()
                view.addSubview(delegateTasksPopUpView)
                formatPopUp(delegateTasksPopUpView, isHidden: false)
   
                
               // membersToChoseTableView.reloadData()
                
                // alimentar o header do popUp (se aproveitando do indexPath)
                iconTaskClickedImageView.image = UIImage(named: localData.chosenDomesticTasks[indexPath.row].icon)
                valueTaskClickedLabel.text = String(localData.chosenDomesticTasks[indexPath.row].value)
                
                let taskName = localData.chosenDomesticTasks[indexPath.row].name
                whoWillDoThatLabel.text = "quem vai \(taskName)?"
                
                print("ui, deleguei")
            }
            
        } else if collectionView == tasksToChoseCollection {
            
            let cell: ChoseTaskCollectionCell = collectionView.cellForItem(at: indexPath) as! ChoseTaskCollectionCell
            
            cell.layer.cornerRadius = 5
            cell.layer.backgroundColor = #colorLiteral(red: 1, green: 0.862745098, blue: 0.4705882353, alpha: 0.2223447086)
            
            let taskTaped = DomesticTask(
                name: localData.allDomesticTasks[indexPath.row].name,
                // cell.taskNameLabel.text!,
                iconColor: localData.allDomesticTasks[indexPath.row].icon,
                value1to5: localData.allDomesticTasks[indexPath.row].value
                // Int(cell.taskValueLabel.text!)!
            
            )
            
            
            // bug do contains resolvido!! amem francisco
            
            if localData.tasksBeingChosen.contains(taskTaped) {
                var index = 0
                while index < localData.tasksBeingChosen.count {
                    if localData.tasksBeingChosen[index] == taskTaped {
                        localData.tasksBeingChosen.remove(at: index)
                        break
                    }
                    index = index + 1
                }
                print("\(localData.allDomesticTasks[indexPath.row].name) removida")
                
            } else {
                localData.tasksBeingChosen.append(taskTaped)
                print("\(localData.allDomesticTasks[indexPath.row].name) adicionada")
            }
            
//            if localData.tasksBeingChosen.contains(taskTaped) {
//                //////////// AQUIEE
//               localData.tasksBeingChosen.remove(at: indexPath.row)
//            } else { // se não contêm
//                localData.tasksBeingChosen.append(taskTaped)
//            }
        
        // domesticTasksCollection.reloadData() //- quando chama reloadData() ele relê o cellForItemAt e refaz as células por ele, ignorando qualquer mudança posterior
            
        } else if collectionView == tasksToValidateCollection {
            
            let cell: ValidateTasksCollectionCell = collectionView.cellForItem(at: indexPath) as! ValidateTasksCollectionCell
            ///////
            
            // atualmente esse primeiro if ta desnecessario (mas deixa ele aqui)
            if cell.taskToValidateIcon.image == UIImage(named: "ok.png") {  // VALIDATE BUTTON
                // validar e fechar popUp
                closeBlur()
                validateTasksPopUpView.isHidden = true
                
            } else if cell.taskToValidateIcon.image == nil {   // CELULA VAZIA
                // nada acontece, celulas invisiveis pfvr nao crashem!!
                print("vc recebeu a maldição da celula invisivel, toque no seu amiguinho mais próximo pra repassar")
                
            } else {   // ATIVIDADES PRA VALIDAR
                // adiciona ou retira do array auxiliar de validadas
                // aqui no didSelect ta trocando, lá tá só mostrando, por isso que é invertido
                if cell.isValidateCellSelected == true {
                    cell.alpha = 0.6 // fica morta   // clarinho
                    cell.isValidateCellSelected = false
                    // print("morreu")
                } else {
                    cell.alpha = 1 // fica viva   // normal
                    cell.isValidateCellSelected = true
                    // print("renasceu")
                    
                }
                
                let taskTapped = DomesticTask(
                    name: localData.chosenDomesticTasks[indexPath.row].name,
                    iconColor: localData.chosenDomesticTasks[indexPath.row].icon,
                    value1to5: localData.chosenDomesticTasks[indexPath.row].value
                )
                
                if localData.tasksBeingValidated.contains(taskTapped) { // agora entra
                    var i = 0
                    while i < localData.tasksBeingValidated.count {
                        if localData.tasksBeingValidated[i] == taskTapped {
                            localData.tasksBeingValidated.remove(at: i)
                            break
                        }
                        i = i + 1
                    }
                    print("\(localData.chosenDomesticTasks[indexPath.row].name) removida")
                    
                } else {
                    localData.tasksBeingValidated.append(taskTapped)
                    print("\(localData.chosenDomesticTasks[indexPath.row].name) adicionada")
                }
            
            }
            
            //////
        
            
        }
    }
    
}




//MARK: TextField
extension ViewController: UITextFieldDelegate {
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
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
        imageSelectedColor.frame = CGRect(x: 17, y: 218, width: 60, height: 60)
        imageSelectedColor.center = chooseColor1Outlet.center
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
        imageSelectedColor.frame = CGRect(x: 116, y: 218, width: 60, height: 60)
        imageSelectedColor.center = chooseColor2Outlet.center
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
        imageSelectedColor.frame = CGRect(x: 218, y: 218, width: 60, height: 60)
        imageSelectedColor.center = chooseColor3Outlet.center
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
        imageSelectedColor.frame = CGRect(x: 17, y: 288, width: 60, height: 60)
        imageSelectedColor.center = chooseColor4Outlet.center
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
        imageSelectedColor.frame = CGRect(x: 116, y: 288, width: 60, height: 60)
        imageSelectedColor.center = chooseColor5Outlet.center
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
        imageSelectedColor.frame = CGRect(x: 218, y: 288, width: 60, height: 60)
        imageSelectedColor.center = chooseColor6Outlet.center
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
        
        // Disabling chosen colors
        for color in chosenColor {
            if color == "1" {
                chooseColor1Outlet.backgroundColor = #colorLiteral(red: 0.794226794, green: 0.794226794, blue: 0.794226794, alpha: 1)
                chooseColor1Outlet.isEnabled = false
            }
            if color == "2" {
                chooseColor2Outlet.backgroundColor = #colorLiteral(red: 0.794226794, green: 0.794226794, blue: 0.794226794, alpha: 1)
                chooseColor2Outlet.isEnabled = false
            }
            if color == "3" {
                chooseColor3Outlet.backgroundColor = #colorLiteral(red: 0.794226794, green: 0.794226794, blue: 0.794226794, alpha: 1)
                chooseColor3Outlet.isEnabled = false
            }
            if color == "4" {
                chooseColor4Outlet.backgroundColor = #colorLiteral(red: 0.794226794, green: 0.794226794, blue: 0.794226794, alpha: 1)
                chooseColor4Outlet.isEnabled = false
            }
            if color == "5" {
                chooseColor5Outlet.backgroundColor = #colorLiteral(red: 0.794226794, green: 0.794226794, blue: 0.794226794, alpha: 1)
                chooseColor5Outlet.isEnabled = false
            }
            if color == "6" {
                chooseColor6Outlet.backgroundColor = #colorLiteral(red: 0.794226794, green: 0.794226794, blue: 0.794226794, alpha: 1)
                chooseColor6Outlet.isEnabled = false
            }
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
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: localData.chosenDomesticTasks)
        UserDefaults.standard.set(encodedData, forKey: "chosenTask")
 
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
    
    // fechar e delegar OK
    @IBAction func delegateTaskButton(_ sender: Any) {
        
        // delegar aqui
//        colorCounter = colorCounter + 1
        print("ui, deleguei!")
        delegateTasksPopUpView.isHidden = true
        closeBlur()
    }
}



//MARK: Sixth PopUp actions (validate tasks)
extension ViewController {
    // voltar
    @IBAction func goBackFromValidadePopUp(_ sender: Any) {
        validateTasksPopUpView.isHidden = true
        closeBlur()
    }
    // ok
    @IBAction func validateTasksButton(_ sender: Any) {
        
        var index = 0
        while index < localData.tasksBeingValidated.count {
            
            if localData.chosenDomesticTasks.contains(localData.tasksBeingValidated[index]) {
                let indexOfTask = localData.chosenDomesticTasks.index(of: localData.tasksBeingValidated[index])
                print(indexOfTask!)
                localData.chosenDomesticTasks[indexOfTask!].isDone = true
                print(localData.chosenDomesticTasks[indexOfTask!].isDone)
                
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: localData.chosenDomesticTasks)
                UserDefaults.standard.set(encodedData, forKey: "chosenTask")
                domesticTasksCollection.reloadData()
            }
            index = index + 1
        }
        // validar aqui
        
        validateTasksPopUpView.isHidden = true
        closeBlur()
    }
}


//MARK: Seventh PopUp actions (see points)
extension ViewController {
    
     //abrir gambiarra
    @IBAction func gotinhasPopUpGambiarra(_ sender: Any) {
        validateTasksPopUpView.isHidden = true
        // openBlur()
        formatPopUp(saysPointsEarnedPopUpView, isHidden: false)
    }
    
    // ok
    @IBAction func confirmPointsEarnedButton(_ sender: Any) {
        saysPointsEarnedPopUpView.isHidden = true
        closeBlur()
    }
}


//MARK: Eight PopUp actions (see winner)
extension ViewController {
    
    // abrir gambiarra
    @IBAction func vencedorPopUpGambiarra(_ sender: Any) {
        validateTasksPopUpView.isHidden = true
        // openBlur()
        formatPopUp(saysWinnerPopUpView, isHidden: false)
    }
    
    // share
    @IBAction func shareWinnerButton(_ sender: Any) {
        // copiado do outro
        let activityVC = UIActivityViewController(activityItems: ["Julia ganhou!!"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated:  true, completion: nil)
    }
    
    // ok
    @IBAction func confirmWinnerButton(_ sender: Any) {
        saysWinnerPopUpView.isHidden = true
        // o blur continua
        formatPopUp(startNewDayPopUpView, isHidden: false)
    }
}


//MARK: Nineth PopUp actions (start new day)
extension ViewController {
    // sim
    @IBAction func keepTasksToNewDayButton(_ sender: Any) {
        startNewDayPopUpView.isHidden = true
        closeBlur()
    }

    // nao
    @IBAction func resetTasksToNewDayButton(_ sender: Any) {
        // resetar o que precisar
        localData.chosenDomesticTasks = []
        startNewDayPopUpView.isHidden = true
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

//MARK: Progress View Tempo
extension ViewController {
    
    //como eu descubro quanto tempo se passou desde 5am????????
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            seconds = seconds24h
            openBlur()
            formatPopUp(saysWinnerPopUpView, isHidden: false)
            runTimer()
            //Mandar notificação de que o dia acabou
        } else {
            timeToEndOfDayProgressView.progress -= 1/seconds24h
            seconds -= 1
            timeToEndOfDayLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        //let seconds = Int(time) % 60
        return String(format:"%02ih%02imin", hours, minutes)
    }
}




