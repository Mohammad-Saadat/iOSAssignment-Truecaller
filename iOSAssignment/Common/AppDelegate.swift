//
//  AppDelegate.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var networkManager = NetworkManagerFactory().createNetworkManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        self.window?.rootViewController = setHomeViewcontroller()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}


// ===============
// MARK: - Methods
// ===============
extension AppDelegate {
    class func getInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func setHomeViewcontroller() -> UIViewController {
        let dc = HomeDependencyContainer()
        let homeVC = dc.makeHomeViewController()
        let navVc = CustomNavigationController(rootViewController: homeVC)
        return navVc
    }
}
