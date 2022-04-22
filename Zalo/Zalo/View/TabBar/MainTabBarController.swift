//
//  MainTabBarController.swift
//  Zalo
//
//  Created by AnhLe on 14/04/2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Subview
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
}
// MARK: - Extension
extension MainTabBarController {
    
    func style(){
        tabBar.isTranslucent = false
//        tabBar.tintColor = .blueZalo

        
    }
    func layout(){
        let homeVC = HomeViewController()
        let contactVC = ContactViewController()
        let personalVC = PersonalViewController()
        
        homeVC.setTabBarImage(image: Image.message, title: "Tin nhắn", withTag: 0)
        contactVC.setTabBarImage(image: Image.contact, title: "Danh bạ", withTag: 1)
        personalVC.setTabBarImage(image: Image.person, title: "Cá nhân", withTag: 2)
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let contactNC = UINavigationController(rootViewController: contactVC)
        let personalNC = UINavigationController(rootViewController: personalVC)
        
        let tabBarLists = [homeNC, contactNC, personalNC]
        
        viewControllers = tabBarLists
    }
}
