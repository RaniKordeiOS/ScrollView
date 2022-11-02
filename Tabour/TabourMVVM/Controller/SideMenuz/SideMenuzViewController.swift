//
//  SideMenuzViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 08/10/22.
//

import UIKit
import SwiftKeychainWrapper

class SideMenuzViewController: UIViewController {
    
    @IBOutlet weak var heightOfTable: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelMobile: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    let userDeactivate_VM = UserDeactivate_VM()
    let userLogout_VM = Logout_VM()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    lazy var tablecellID: String = "SettingTableViewCell"
    lazy var listSetting: [String] = []
    
    //MARK:      INITIALIZATION
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
        configureImage()
    }
    func configureImage()
    {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = colorRGB(r: 233, g: 196, b: 106).cgColor
    }
    func addDataToSettingList()
    {
        self.listSetting.append("My Bookings")
        self.listSetting.append("Membership")
        self.listSetting.append("Contact Us")
        self.listSetting.append("Tabour Policy")
        self.listSetting.append("Terms & Conditions")
        let userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
        if userG == 0
        {
            self.listSetting.append("Login")
        }
        else
        {
            self.listSetting.append("Logout")
        }
        self.listSetting.append("Deactivate")
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heightOfTable?.constant = self.myTableView.contentSize.height
    }
    func configureTableView()  {
        addDataToSettingList()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: tablecellID, bundle: nil), forCellReuseIdentifier: tablecellID)
        myTableView.backgroundColor = .clear
        self.heightOfTable?.constant = self.myTableView.contentSize.height
        
    }
    func configureViews()  {
    
        let userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
        if userG == 0
        {
            self.labelMobile.text = ""
            self.labelName.text = ""
        }
        else
        {
            let mobileNumberData = KeychainWrapper.standard.string(forKey: "userMobile") ?? ""
            let nameData = KeychainWrapper.standard.string(forKey: "userName") ?? ""
            self.labelMobile.text = mobileNumberData
            self.labelName.text = nameData
        }
    }
    
}
//MARK:    UITableView delegate

extension SideMenuzViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listSetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tablecellID, for: indexPath) as! SettingTableViewCell
        cell.setCell(name: listSetting[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  var selectedCell = tableView.dequeueReusableCell(withIdentifier: tablecellID, for: indexPath) as! SettingTableViewCell
        // selectedCell.contentView.backgroundColor = .clear
        
        if (indexPath.item == (6 - 1)){
            let userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
            if userG == 0
            {
                moveToLoginPageVC1()
            }
            else
            {
                callAPIToLogoutUser()
            }
        }
        else if (indexPath.item == 6)
        {
            callAPIToUserDeactivate()
        }else
        {
            
        }
        
    }
    
    func moveToLoginPageVC1() {
        KeychainWrapper.standard.removeAllKeys()
       // KeychainWrapper.standard.removeObject(forKey: "userIdentity")
        //KeychainWrapper.standard.removeObject(forKey: "authToken")
        weak var pvc = self.presentingViewController
        
        self.dismiss(animated: true, completion: {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
            newViewController.modalPresentationStyle = .overCurrentContext
            
            pvc?.present(newViewController, animated: true, completion: nil)
        })
    }
    /*
     func moveToLoginPageVC2() {
     KeychainWrapper.standard.removeAllKeys()
     
     weak var pvc = self.presentingViewController
     
     self.dismiss(animated: true, completion: {
     let vc = LoginViewController()
     
     pvc?.present(vc, animated: true, completion: nil)
     })
     }
     */
}
extension SideMenuzViewController {
    //MARK: User Deactivate
    func callAPIToUserDeactivate()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        userDeactivate_VM.deactivateUser(user_id: userIdentity!, auth_token: authToken!)
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.moveToLoginPageVC1()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    //MARK: User Logout
    func callAPIToLogoutUser()
    {
        let authToken = KeychainWrapper.standard.string(forKey: "authToken")
        let userIdentity = KeychainWrapper.standard.integer(forKey: "userIdentity")
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        userLogout_VM.logoutUser(user_id: userIdentity!, auth_token: authToken!)
        { (_isTrue, _message, _data) in
            if _isTrue {
                self.moveToLoginPageVC1()
            } else{
                self.showAlertA(msg: _message)
            }
            self.activityIndicator.stopAnimating()
        }
    }
}


