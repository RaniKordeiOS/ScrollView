//
//  SettingTableViewCell.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 10/10/22.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var myViewCell: UIView!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            colorRGB(r: 2, g: 35, b: 47),
            colorRGB(r: 4, g: 47, b: 63),
        ]
      gradient.shouldRasterize = true
       // gradient.locations = [0, 0.25, 1]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        /*
        // Horizontal: left to right.
       gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // Left side.
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) // Right side.
         
        // Diagonal: top left to bottom corner.
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Bottom right corner.
         
         */
        return gradient
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myViewCell.layer.cornerRadius = 5
        self.contentView.backgroundColor = .clear
        myViewCell.backgroundColor = .clear
        labelName.textColor = .white
        
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        myViewCell.backgroundColor = UIColor.clear
        myViewCell.isOpaque = false
        labelName.backgroundColor = UIColor.clear
        labelName.isOpaque = false
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name: String)  {
        //print(self.contentView.frame)
        //print("okz")
        labelName.text = name
         //gradient.frame = myViewCell.bounds
         //myViewCell.layer.addSublayer(gradient)
    }
    
}

//4 47 63  hex 04 2F 3F

//2 35 47  hex 02 23 2F

