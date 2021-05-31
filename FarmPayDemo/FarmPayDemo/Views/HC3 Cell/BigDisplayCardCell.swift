//
//  BigDisplayCardCell.swift
//  FarmPayDemo
//
//  Created by iPHTech20 on 23/05/21.
//

import UIKit

class BigDisplayCardCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var bView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bView.layer.cornerRadius = CORNER_RADIUS_VIEWS
    }
    
}
