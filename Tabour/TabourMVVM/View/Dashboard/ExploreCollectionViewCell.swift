//
//  ExploreCollectionViewCell.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 07/10/22.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var myShadowView: UIView!
    @IBOutlet weak var btnCuisineType: UIButton!
    @IBOutlet weak var btnBookNow: UIButton!
    @IBOutlet weak var btnJoinQueue: UIButton!
    @IBOutlet weak var viewSaveButton: UIView!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var widthLName: NSLayoutConstraint!
    
    @IBOutlet weak var widthLAddress: NSLayoutConstraint!
    
    lazy var listRestCuisineNil = [Cuisine]()
    lazy var listRestCuisine = [Cuisine]()
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
        configureButtons()
    }
    //MARK:  configure View
    func configureViews(){
        myView.layer.cornerRadius = 15
        myImageView.layer.cornerRadius = 15
        myShadowView.layer.cornerRadius = 15
        viewSaveButton.layer.cornerRadius = viewSaveButton.layer.frame.width / 2
        self.btnSave.setTitle("", for: .normal)
        //print("width: \(self.myView.frame.width)")
       // widthLName.constant = self.myView.frame.width * 0.5
       // widthLAddress.constant = self.myView.frame.width * 0.5
       // myView.layoutIfNeeded()
        labelName.numberOfLines = 2
        labelName.sizeToFit()
        //labelAddress.numberOfLines = 2
        //labelAddress.sizeToFit()
    }
    //MARK:  configure Buttons
    func configureButtons(){
        self.btnBookNow.layer.cornerRadius = 6
        self.btnBookNow.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
        
        self.btnJoinQueue.layer.cornerRadius = 6
        self.btnJoinQueue.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
        self.btnJoinQueue.backgroundColor = .white
        
        self.btnCuisineType.layer.cornerRadius = 3
        self.btnCuisineType.layer.borderColor = UIColor.white.cgColor
        self.btnCuisineType.layer.borderWidth = 1
        
    }
    
    
    func setRes(model: AllRestaurantModel, foodCat: Bool, cuisineIdentity: Int)  {
        
        imageDownload(url: model.image ?? "")
        labelName.text = model.name ?? "nn"
        labelAddress.text = model.address ?? "add"
        
        if (foodCat == true)
        {
            self.listRestCuisine = model.restroCuisines ?? listRestCuisineNil
            if (listRestCuisine.count >= 1)
            {
                for item in listRestCuisine{
                    if (item.cuisineID! == cuisineIdentity ){
                        btnCuisineType.setTitle(item.cuisineName!, for: .normal)
                    }
                }
            }
        }
        else
        {
            let inputString = model.cuisineType ?? "Type"
            let splits = inputString.components(separatedBy: ",")
    
            btnCuisineType.setTitle(splits[0], for: .normal)
            }

    }
    func setRes(model: AllRestaurantModel)  {
        
        imageDownload(url: model.image ?? "")
        labelName.text = model.name ?? "nn"
        labelAddress.text = model.address ?? "add"
            let inputString = model.cuisineType ?? "Type"
            let splits = inputString.components(separatedBy: ",")
    
            btnCuisineType.setTitle(splits[0], for: .normal)
    }
    //    DOWN LOAD IMAGE FROM SERVER
        func imageDownload(url: String){
                myImageView.sd_setImage(with: URL(string: url), placeholderImage:UIImage(named: "res"), options: .refreshCached)
        }
}
