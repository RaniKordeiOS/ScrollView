//
//  SplashViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 28/09/22.
//

import UIKit
import AVKit
import AVFoundation
import SwiftKeychainWrapper

class SplashViewController: UIViewController, AVPlayerViewControllerDelegate {
    var player: AVPlayer!
    var layer: AVPlayerLayer!
    var playerViewController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
    }
    func playVideo() {
        let path = Bundle.main.path(forResource: "splash", ofType: "mp4")
        let url = NSURL(fileURLWithPath: path!)
        player = AVPlayer(url:url as URL)
         layer = AVPlayerLayer(player: player)
        layer.frame = self.view.bounds
        layer.videoGravity = .resizeAspect
        view.layer.addSublayer(layer)
        player.play()
        lazy var userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
        lazy var userAKey = KeychainWrapper.standard.string(forKey: "authToken")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if userG == nil && userAKey == nil {
                self.moveToLoginPageVC()
            } else {
            self.moveToHomePageVC()
          //self.moveToLoginPageVC()
                print("\(String(describing: userG)) and  \(String(describing: userAKey))")
            }
      
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    /*
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
                    let currentviewController =  navigationController?.visibleViewController

                    if currentviewController != playerViewController
                    {
                        currentviewController?.present(playerViewController,animated: true,completion:nil)
                    }


                }
    @objc func didfinishplaying(note : NSNotification)
            {
                playerViewController.dismiss(animated: true,completion: nil)
                lazy var userG = KeychainWrapper.standard.integer(forKey: "userIdentity")
                lazy var userAKey = KeychainWrapper.standard.string(forKey: "authToken")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if userG == nil && userAKey == nil {
                        self.moveToLoginPageVC()
                    } else {
                    self.moveToHomePageVC()
                  //self.moveToLoginPageVC()
                        print("\(String(describing: userG)) and  \(String(describing: userAKey))")
                    }
              
                }
            }

    func playVideo() {
                  let path = Bundle.main.path(forResource: "splash", ofType: "mp4")
                    let url = NSURL(fileURLWithPath: path!)
                    player = AVPlayer(url:url as URL)
                    playerViewController = AVPlayerViewController()
                    NotificationCenter.default.addObserver(self, selector: #selector(SplashViewController.didfinishplaying(note:)),name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        playerViewController.player = player
        playerViewController.allowsPictureInPicturePlayback = true
        playerViewController.delegate = self
        playerViewController.player?.play()
        self.present(playerViewController,animated:true,completion:nil)
    }
    */
    
    func moveToHomePageVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "dashboardContainerVC")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func moveToLoginPageVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        newViewController.modalPresentationStyle = .overCurrentContext
        self.present(newViewController, animated: true, completion: nil)
    }
    
}

/*
KeychainWrapper.standard.removeObject(forKey: "userIdentity")
KeychainWrapper.standard.removeObject(forKey: "authToken")
 GUEST USER
 KeychainWrapper.standard.set(0, forKey: "userIdentity")
 KeychainWrapper.standard.set("0", forKey: "authToken")
 
KeychainWrapper.standard.removeObject(forKey: "mobile")
 
KeychainWrapper.standard.removeObject(forKey: "userName")
KeychainWrapper.standard.removeObject(forKey: "userMobile")
KeychainWrapper.standard.removeObject(forKey: "userOTP")
 
 
 
KeychainWrapper.standard.removeObject(forKey: "received_latitude")
KeychainWrapper.standard.removeObject(forKey: "received_longitude")
KeychainWrapper.standard.removeObject(forKey: "locationName")
KeychainWrapper.standard.removeAllKeys()
*/
