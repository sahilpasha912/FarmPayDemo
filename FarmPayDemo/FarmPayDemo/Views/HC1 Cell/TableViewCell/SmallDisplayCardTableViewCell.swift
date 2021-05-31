//
//  SmallDisplayCardTableViewCell.swift
//  FarmPayDemo
//
//  Created by iPHTech20 on 26/05/21.
//

import UIKit

class SmallDisplayCardTableViewCell: UITableViewCell {
    
    // MARK:- outlets
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var cardDetailCollectionView: UICollectionView!{
        didSet{
            cardDetailCollectionView.registerCell(register: COLLECTION_VIEW_CELL_NAMES.HC1_COLLECTIONVIEW, reuseIdentifier: COLLECTION_VIEW_CELL_NAMES.HC1_COLLECTIONVIEW)
            cardDetailCollectionView.delegate = self
            cardDetailCollectionView.dataSource = self
        }
    }
    
    // MARK:- variables
    var smallCard: Card_groups?{
        didSet{
            cardDetailCollectionView.reloadData()
        }
    }
    var designType:DesignTypes?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bView.layer.cornerRadius = CORNER_RADIUS_VIEWS
        cardDetailCollectionView.layer.cornerRadius = CORNER_RADIUS_VIEWS
        
    }
    
}

extension SmallDisplayCardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallCard?.cards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch designType{
        case .kSmall_Display_Card:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL_NAMES.HC1_COLLECTIONVIEW, for: indexPath) as! HCOneCollectionViewCell
            cell.card = smallCard?.cards![indexPath.row]
            return cell
            
        case .kBig_Display_Card:
            
            
            break
        case .some(_):
            break
        case .none:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.cardDetailCollectionView.frame.width, height: self.cardDetailCollectionView.frame.height)
    }
    
    
}
