//
//  HCOneCollectionViewCell.swift
//  FarmPayDemo
//
//  Created by iPHTech20 on 27/05/21.
//

import UIKit

class HCOneCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var bView: UIView!
    
    // MARK:- Variables
    
    var card:Cards?{
        didSet{
            setProperties()
        }
    }
    
    func setProperties() {
        title.text = card?.name
        subTitle.text = card?.title
        
        let color = card?.bg_color
        bView.backgroundColor = UIColor(hexString: color ?? "FFFFFF")
        
        
        let imageUrl = card?.icon?.image_url
        guard let url = URL(string: imageUrl ?? "") else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.img.image = UIImage(data: data!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
