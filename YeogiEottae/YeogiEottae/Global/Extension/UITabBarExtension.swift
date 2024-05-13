//
//  UITabBarExtension.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/11.
//

import UIKit

extension UITabBarController {
    
    static func getDefault() -> UITabBarController {
        
        let tabBarCon = UITabBarController()
        
        let searchListNaviCon = UINavigationController(rootViewController: SearchListViewController())
        
        tabBarCon.setViewControllers([UIViewController(), searchListNaviCon, UIViewController(), UIViewController(), UIViewController()], animated: false)
        tabBarCon.tabBar.items?[0].image = UIImage(named: "home")
        tabBarCon.tabBar.items?[0].title = "홈"
        tabBarCon.tabBar.items?[1].image = UIImage(named: "search")
        tabBarCon.tabBar.items?[1].title = "검색"
        tabBarCon.tabBar.items?[2].image = UIImage(named: "position")
        tabBarCon.tabBar.items?[2].title = "주변"
        tabBarCon.tabBar.items?[3].image = UIImage(named: "like")
        tabBarCon.tabBar.items?[3].title = "찜"
        tabBarCon.tabBar.items?[4].image = UIImage(named: "my")
        tabBarCon.tabBar.items?[4].title = "내 정보"
        
        
        tabBarCon.tabBar.tintColor = UIColor.brandColor(brightness: .Brand)
        tabBarCon.selectedIndex = 1
        return tabBarCon
    }
    
    
    
}
