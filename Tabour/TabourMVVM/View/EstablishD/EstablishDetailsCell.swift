//
//  EstablishDetailsCell.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 27/10/22.
//

import UIKit

class EstablishDetailsCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCell(photoR: UIImage, name: String)
    {
        self.name.text = name
        self.image.image = photoR
    }
    func setImage(data: EstImage, name: String)
    {
        imageDownload(url: data.image ?? "")
        self.name.text = name
    }
    //    DOWN LOAD IMAGE FROM SERVER
        func imageDownload(url: String){
                image.sd_setImage(with: URL(string: url), placeholderImage:UIImage(named: "res"), options: .refreshCached)
        }
    

}
