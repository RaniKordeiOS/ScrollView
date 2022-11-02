//
//  DashboardContainerVC.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 04/10/22.
//
import UIKit

class DashboardContainerVC: UIViewController {
    // MARK: - Properties
    var menuController: UIViewController!
    var centerController: UIViewController!
    var viewBehindHomeView: UIView!
    var isExpanded = false
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    // MARK: - Handlers
    func configureHomeController() {
        viewBehindHomeView = UIView(frame: self.view.frame)
        view.addSubview(viewBehindHomeView)
        
        let homeController = HomeBaseVC()
        homeController.homeControllerDelegate = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }

    func configureMenuController() {
        if menuController == nil{
            //add our menu controller here
            menuController = SideMenuzViewController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self )
           // print("Did add menu controller...")
        }
    }
    func showMenuController(shouldExpand: Bool)
    {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        
       // print(screenHeight)
      //  print(screenRect)
       // print(self.centerController.view.frame)
        //print(screenHeight * 0.12)
      print(screenHeight * 0.125)
        let constantH = screenHeight * 0.125
        if shouldExpand{
            //show menu
            //print("show menu")
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                //again added
                self.centerController.view.layer.cornerRadius = 30
                self.centerController.view.frame.origin.y = self.centerController.view.frame.origin.y + 80
                self.centerController.view.frame.size.height = self.centerController.view.frame.size.height - 110
                
                //add view on back
                self.viewBehindHomeView.backgroundColor = self.colorRGB(r: 64, g: 121, b: 140)
                self.viewBehindHomeView.frame.origin.x = self.viewBehindHomeView.frame.width - 100
                //again added
                self.viewBehindHomeView.layer.cornerRadius = 30
                //self.viewBehindHomeView.frame.origin.y = self.viewBehindHomeView.frame.origin.y + 100
               // self.viewBehindHomeView.frame.size.height = self.viewBehindHomeView.frame.size.height - 110
                
                self.viewBehindHomeView.frame.origin.y = self.viewBehindHomeView.frame.origin.y + 100
                self.viewBehindHomeView.frame.size.height = self.viewBehindHomeView.frame.size.height - constantH
                
            }, completion: nil)
        }
        else
        {
            //hide menu
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                //again added
                self.centerController.view.layer.cornerRadius = 0
                self.centerController.view.frame.origin.y = self.centerController.view.frame.origin.y - 80
                self.centerController.view.frame.size.height = self.centerController.view.frame.size.height + 110
                
                
                //add view on back
                self.viewBehindHomeView.frame.origin.x = self.viewBehindHomeView.frame.width + 100
                self.viewBehindHomeView.frame.origin.y = self.viewBehindHomeView.frame.origin.y - 100
                self.viewBehindHomeView.layer.cornerRadius = 0
               // self.viewBehindHomeView.frame.size.height = self.viewBehindHomeView.frame.size.height + 110
                self.viewBehindHomeView.frame.size.height = self.viewBehindHomeView.frame.size.height + constantH
               
            }, completion: nil)
        }
    }
    
    
}
extension DashboardContainerVC: HomeControllerDelegate{
    func handleMenuToggle() {
        //configureMenuController()
        if !isExpanded {
            configureMenuController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }

}
