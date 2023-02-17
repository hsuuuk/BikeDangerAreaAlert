//
//  MainTabController.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/15.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    func setupViewController() {
        let map = UINavigationController(rootViewController: MapController())
        map.tabBarItem.image = UIImage(systemName: "location.circle.fill")
        map.tabBarItem.title = "지도"
        
        let setting = UINavigationController(rootViewController: SettingController())
        setting.tabBarItem.image = UIImage(systemName: "ellipsis")
        setting.tabBarItem.title = "설정"
                
        let tabBarappearance = UITabBarAppearance()
        tabBarappearance.backgroundColor = .white
        map.tabBarItem.standardAppearance = tabBarappearance
        map.tabBarItem.scrollEdgeAppearance = tabBarappearance
        tabBar.tintColor = .black

        //viewControllers = [map, setting]
        viewControllers = [setting]
    }
}
