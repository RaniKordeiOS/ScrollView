//
//  HomeBaseVC.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

class HomeBaseVC: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Properties
    var homeControllerDelegate: HomeControllerDelegate?
  //  var tap : UITapGestureRecognizer!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        view.backgroundColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .white
        
        configureNavigationBar()
//        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleViewDismiss))
//
//        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//        tap.cancelsTouchesInView = false
//
//        view.addGestureRecognizer(tap)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create Tab one
        let tabOne = HomeNewViewController()
        
        let tabOneBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeD.png")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homeActive.png")?.withRenderingMode(.alwaysOriginal))
        
        tabOne.tabBarItem = tabOneBarItem
        // Create Tab two
        let tabTwo = SearchTabViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Search", image: UIImage(named: "searchD.png")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "searchActive.png")?.withRenderingMode(.alwaysOriginal))
        tabTwo.tabBarItem = tabTwoBarItem2
        // Create Tab three
        let tabThree = SavedViewController()
        let tabThreeBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "savedD.png")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "savedActive.png")?.withRenderingMode(.alwaysOriginal))
        tabThree.tabBarItem = tabThreeBarItem
       
        // Create Tab four
        let tabFour = UpdateProfileViewController()
        let tabFourBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileD.png")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "profileActive.png")?.withRenderingMode(.alwaysOriginal))
        tabFour.tabBarItem = tabFourBarItem
        
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: colorRGB(r: 64, g: 121, b: 140)], for: .normal)
        self.tabBar.unselectedItemTintColor = UIColor.white
          
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: colorRGB(r: 233, g: 196, b: 106)], for: .selected)

        if let items = self.tabBar.items {
                    // Setting the title text color of all tab bar items:
                    for item in items {
                        item.setTitleTextAttributes([.foregroundColor: colorRGB(r: 233, g: 196, b: 106)], for: .selected)
                        item.setTitleTextAttributes([.foregroundColor: colorRGB(r: 64, g: 121, b: 140)], for: .normal)
                    }
                }
        
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       // print("Selected \(viewController.title!)")
    }
    // MARK: - Handlers
    @objc func handleMenuToggle() {
        //   print("Toggle menu....")
        homeControllerDelegate?.handleMenuToggle()
    }

    @objc func handleNotification() {
        print("notification...")
    }
    func configureNavigationBar() {
        navigationController?.navigationBar.standardAppearance.backgroundColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        let userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
        print(userG ?? "no identity")
       if userG == 0
        {
            navigationItem.title = "Hi!,"
        }
        else
        {
           let userName = KeychainWrapper.standard.string(forKey: "userName") ?? ""
          //  print(userName ?? "no name")
           navigationItem.title = "Hi! \(userName),"
          //  navigationItem.title = "Hi!,"
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menuLeft")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bellRight")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleNotification))
    }
    
    func countryFlag(countryCode: String) -> String {
      let base = 127397
      var tempScalarView = String.UnicodeScalarView()
      for i in countryCode.utf16 {
        if let scalar = UnicodeScalar(base + Int(i)) {
          tempScalarView.append(scalar)
        }
      }
      return String(tempScalarView)
    }
}
