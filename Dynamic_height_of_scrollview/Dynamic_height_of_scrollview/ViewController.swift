//
//  ViewController.swift
//  Dynamic_height_of_scrollview
//
//  Created by Dharmesh Kothari on 21/10/22.
//https://youtu.be/0A8OKp5xCdQ
//Dynamic ScrollView in Swift 5 and Xcode 11
//https://youtu.be/1CHadfe_2G4
import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet var mysuperview: UIView!
    var isHidden = false
    
    @IBOutlet weak var purpleView: UIView!

    @IBOutlet weak var heightPurpleView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.heightPurpleView.constant = mysuperview.frame.height * 0.05
    }
    @IBAction func onclickDone(_ sender: UIButton) {
        if(isHidden)
        {
            self.heightPurpleView.constant = 0//your constant value
            self.purpleView.isHidden = true
            self.view.layoutIfNeeded()
            self.isHidden = false
            
        }else{
            self.heightPurpleView.constant = mysuperview.frame.height * 0.05//your constant value
            self.purpleView.isHidden = false
            self.view.layoutIfNeeded()
            self.isHidden = true
        }
        self.view.setNeedsUpdateConstraints()
        
    }
    
    
}

