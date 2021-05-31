//
//  HomeVC.swift
//  FarmPayDemo
//
//  Created by iPHTech20 on 23/05/21.
//

import UIKit

enum DesignTypes : String{
    case kSmall_Display_Card = "HC1"
    case kBig_Display_Card = "HC3"
    case kImage_Card = "HC5"
    case kSmall_Card_With_Arrow = "HC6"
    case kDynamic_width_Card = "HC9"
}

class HomeVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cardListTableView: UITableView!{
        didSet{
            tableViewDidSet()
        }
    }
    
    
    // MARK:- Variables
    var cardDetails : CardDetail?
    let SMALL_DISPLAY_CARD_HEIGHT:CGFloat = 74
    let BIG_DISPLAY_CARD_HEIGHT:CGFloat = 364
    let IMAGE_DISPLAY_CARD_HEIGHT:CGFloat = 145
    let SMALL_DISPLAY_CARD_WITH_ARROW_HEIGHT:CGFloat = 74
    let DYNAMIC_DISPLAY_CARD_HEIGHT:CGFloat = 209
    
    // MARK:- Viewcontroller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setViewProperties()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        callNetwork()
    }
    
    
    //MARK:- Functions
    func setViewProperties() {
        
        setfooterCurve(baseView: topView, borderColor: .clear, btnView: nil, margin: 0, curveAtTop: false, curveRadius: 10, curveTopBottom: true)
        
        cardListTableView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0)
    }
    
    
    
    func tableViewDidSet(){
        cardListTableView.delegate = self
        cardListTableView.dataSource = self
        
        cardListTableView.registerCell(register: TABLE_VIEW_CELL_NAMES.HC1_TABLEVIEW_CELL, reuseIdentifier: TABLE_VIEW_CELL_NAMES.HC1_TABLEVIEW_CELL)
        cardListTableView.registerCell(register: TABLE_VIEW_CELL_NAMES.HC3_TABLEVIEW_CELL, reuseIdentifier: TABLE_VIEW_CELL_NAMES.HC3_TABLEVIEW_CELL)
        cardListTableView.registerCell(register: TABLE_VIEW_CELL_NAMES.HC5_TABLEVIEW_CELL, reuseIdentifier: TABLE_VIEW_CELL_NAMES.HC5_TABLEVIEW_CELL)
        cardListTableView.registerCell(register: TABLE_VIEW_CELL_NAMES.HC6_TABLEVIEW_CELL, reuseIdentifier: TABLE_VIEW_CELL_NAMES.HC6_TABLEVIEW_CELL)
        cardListTableView.registerCell(register: TABLE_VIEW_CELL_NAMES.HC9_TABLEVIEW_CELL, reuseIdentifier: TABLE_VIEW_CELL_NAMES.HC9_TABLEVIEW_CELL)
    }
    
}

// MARK:- Extension for API
extension HomeVC {
    
    //MARK:- Call response
    func callNetwork(){
        NetworkManager.getResponseFromApi(url: URL_CARDS_LIST) { (result) in
            switch result {
            case let .success(data):
                print(data)
                self.cardDetails = data
                
                DispatchQueue.main.async {
                    self.cardListTableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}


//MARK:- Extension for tableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    // MARK:- TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardDetails?.card_groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cardType = cardDetails?.card_groups![indexPath.row].design_type
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_NAMES.HC1_TABLEVIEW_CELL, for: indexPath) as! SmallDisplayCardTableViewCell
        
        switch DesignTypes(rawValue: cardType!) {
        
        case .kSmall_Display_Card:
            let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_NAMES.HC1_TABLEVIEW_CELL, for: indexPath) as! SmallDisplayCardTableViewCell
            cell.designType = .kSmall_Display_Card
            cell.smallCard = cardDetails?.card_groups![indexPath.row]
            return cell
             
        case .kBig_Display_Card:
            let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_NAMES.HC1_TABLEVIEW_CELL, for: indexPath) as! SmallDisplayCardTableViewCell
            cell.designType = .kBig_Display_Card
            cell.smallCard = cardDetails?.card_groups![indexPath.row]
            return cell
            
        case .kImage_Card:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_NAMES.HC5_TABLEVIEW_CELL,for: indexPath)
            return cell
        case .kSmall_Card_With_Arrow:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_NAMES.HC6_TABLEVIEW_CELL,for: indexPath)
            return cell
        case .kDynamic_width_Card:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_NAMES.HC9_TABLEVIEW_CELL,for: indexPath)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    
    // MARK:- Data Source
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cardType = cardDetails?.card_groups![indexPath.row].design_type
        
        switch DesignTypes(rawValue: cardType!) {
        case .kSmall_Display_Card:
            break
        case .kBig_Display_Card:
            break
        case .kImage_Card:
            break
        case .kSmall_Card_With_Arrow:
            break
        case .kDynamic_width_Card:
            break
        default:
            break
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cardType = cardDetails?.card_groups![indexPath.row].design_type
        
        switch DesignTypes(rawValue: cardType!) {
        case .kSmall_Display_Card:
            return SMALL_DISPLAY_CARD_HEIGHT
        case .kBig_Display_Card:
            return BIG_DISPLAY_CARD_HEIGHT
        case .kImage_Card:
            return IMAGE_DISPLAY_CARD_HEIGHT
        case .kSmall_Card_With_Arrow:
            return SMALL_DISPLAY_CARD_WITH_ARROW_HEIGHT
        case .kDynamic_width_Card:
            return DYNAMIC_DISPLAY_CARD_HEIGHT
        default:
            break
        }
        return 0
    }
    
}


