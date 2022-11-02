//
//  FoodCategoryCell.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 07/10/22.
//

import UIKit
import SDWebImage

class FoodCategoryCell: UICollectionViewCell {

    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelFood: UILabel!
    lazy var id : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let radius = myView.frame.width * 0.1
        myView.layer.cornerRadius = radius
        myView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
    }
    func setData(model: AllFoodCategriesModel)  {
        self.imageDownload(url: model.image ?? "")
        labelFood.text = model.name ?? ""
        id = model.id!
    }
    //    DOWN LOAD IMAGE FROM SERVER
        func imageDownload(url: String){
                imageView.sd_setImage(with: URL(string: url), placeholderImage:UIImage(named: "food"), options: .refreshCached)
        }


}
