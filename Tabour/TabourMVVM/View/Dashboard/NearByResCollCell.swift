//
//  NearByResCollCell.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 11/10/22.
//

import UIKit

class NearByResCollCell: UICollectionViewCell {

    @IBOutlet weak var viewBackSaveBtn: UIView!
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var labelDashView: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelNextAvailableSlots: UILabel!
    
    @IBOutlet weak var btnJoinQueue: UIButton!

    @IBOutlet weak var btnBookNow: UIButton!
    
    @IBOutlet weak var cuisineName: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var label4: UILabel!
    var listAvailableSlot: [Slot] = []
    var listAvailableSlotNil : [Slot] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        labelName.numberOfLines = 2
        labelName.sizeToFit()
        //labelAddress.numberOfLines = 2
       // labelAddress.sizeToFit()
        myView.layer.cornerRadius = 15
        myImageView.layer.cornerRadius = 8
        addressView.backgroundColor = .clear
        viewBackSaveBtn.layer.cornerRadius = viewBackSaveBtn.layer.frame.width / 2
        self.btnSave.setTitle("", for: .normal)
        //print("width: \(self.myView.frame.width)")
        configureButtons()
        configureLabelSlot()
        configureAvSlot()
    }
   func configureAvSlot(){
       listAvailableSlotNil.append(Slot(slot: "10.00 AM", booked: 0, availableSlotLeft: 0))
       listAvailableSlotNil.append(Slot(slot: "10.30 AM", booked: 0, availableSlotLeft: 0))
       listAvailableSlotNil.append(Slot(slot: "11.00 AM", booked: 0, availableSlotLeft: 0))
       listAvailableSlotNil.append(Slot(slot: "11.30 AM", booked: 0, availableSlotLeft: 0))
       
       label1.text = "10.00 AM"
       label2.text = "10.30 AM"
       label3.text = "11.00 AM"
       label4.text = "11.30 AM"
    }
    
    //MARK:  configure Label Slots
    func configureLabelSlot(){
        label1.layer.cornerRadius = 3
        self.label1.layer.borderColor = UIColor.lightGray.cgColor
        self.label1.layer.borderWidth = 1
        label2.layer.cornerRadius = 3
        self.label2.layer.borderColor = UIColor.lightGray.cgColor
        self.label2.layer.borderWidth = 1
        label3.layer.cornerRadius = 3
        self.label3.layer.borderColor = UIColor.lightGray.cgColor
        self.label3.layer.borderWidth = 1
        label4.layer.cornerRadius = 3
        self.label4.layer.borderColor = UIColor.lightGray.cgColor
        self.label4.layer.borderWidth = 1
    }
    //MARK:  configure Buttons
    func configureButtons(){
        self.btnBookNow.layer.cornerRadius = 6
        self.btnBookNow.backgroundColor = colorRGB(r: 233, g: 196, b: 106)
        
        self.btnJoinQueue.layer.cornerRadius = 6
        self.btnJoinQueue.setTitleColor(colorRGB(r: 64, g: 121, b: 140), for: UIControl.State.normal)
        self.btnJoinQueue.backgroundColor = .white
        self.btnJoinQueue.layer.borderColor = colorRGB(r: 64, g: 121, b: 140).cgColor
        self.btnJoinQueue.layer.borderWidth = 2
        
        self.cuisineName.layer.cornerRadius = 3
        self.cuisineName.layer.borderColor = colorRGB(r: 244, g: 162, b: 97).cgColor
        self.cuisineName.layer.borderWidth = 1
        
    }
    
    @IBAction func onClickBookNow(_ sender: UIButton) {
    }
    
    @IBAction func onClickJoinQueue(_ sender: UIButton) {
    }
    
    @IBAction func onClickSave(_ sender: UIButton) {
    }
    
    func setNearByRes(model: NearByRestaurantsModel)  {
        
        imageDownload(url: model.image ?? "")
        labelName.text = model.name ?? "nn"
        labelAddress.text = model.address ?? "add"
        let inputString = model.cuisineType ?? "Type"
        let splits = inputString.components(separatedBy: ",")
        
        cuisineName.setTitle(splits[0], for: .normal)
        
        listAvailableSlot =  model.availableSlots ?? listAvailableSlotNil
        // print("  slot count: \(listAvailableSlot.count)")
        let c = listAvailableSlot.count
        
        if c == 1
        {
            label1.text = listAvailableSlot[0].slot
        }else if c == 2
        {
            label1.text = listAvailableSlot[0].slot
            label2.text = listAvailableSlot[1].slot
        }else if c == 3
        {
            label1.text = listAvailableSlot[0].slot
            label2.text = listAvailableSlot[1].slot
            label3.text = listAvailableSlot[2].slot
        }
        else if c == 0
    {
        label1.text = "10.00 AM"
    }
        else
        {
            label1.text = listAvailableSlot[0].slot
            label2.text = listAvailableSlot[1].slot
            label3.text = listAvailableSlot[2].slot
            label4.text = listAvailableSlot[3].slot
        }
    }
    
    func setResFilters(model: ResFiltersModel)
    {
        imageDownload(url: model.image ?? "")
        labelName.text = model.name ?? "nn"
        labelAddress.text = model.address ?? "add"
        let inputString = model.cuisineType ?? "Type"
        let splits = inputString.components(separatedBy: ",")
        
        cuisineName.setTitle(splits[0], for: .normal)
        
        listAvailableSlot =  model.availableSlots ?? listAvailableSlotNil
       // print("  slot count: \(listAvailableSlot.count)")
        
        let c = listAvailableSlot.count
        
        if c == 1
        {
            label1.text = listAvailableSlot[0].slot
        }else if c == 2
        {
            label1.text = listAvailableSlot[0].slot
            label2.text = listAvailableSlot[1].slot
        }else if c == 3
        {
            label1.text = listAvailableSlot[0].slot
            label2.text = listAvailableSlot[1].slot
            label3.text = listAvailableSlot[2].slot
        }else if c == 0
    {
        label1.text = "10.00 AM"
    }
        else
        {
            label1.text = listAvailableSlot[0].slot
            label2.text = listAvailableSlot[1].slot
            label3.text = listAvailableSlot[2].slot
            label4.text = listAvailableSlot[3].slot
        }
    }
    
    //    DOWN LOAD IMAGE FROM SERVER
        func imageDownload(url: String){
                myImageView.sd_setImage(with: URL(string: url), placeholderImage:UIImage(named: "res"), options: .refreshCached)
        }
    
}
