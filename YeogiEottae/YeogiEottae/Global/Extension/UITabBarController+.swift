//
//  UITabBarController+.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit

extension UITabBarController {
    
    static func getDefault() -> UITabBarController {
        let tabBarController = UITabBarController()
        let searchListNaviCon = UINavigationController(rootViewController: SearchListViewController())

        tabBarController.setViewControllers(
            [
                UINavigationController(rootViewController: CompareRoomViewController()),
                searchListNaviCon,
                UIViewController(),
                UIViewController(),
                UIViewController()
            ],
            animated: false
        )
        
        tabBarController.tabBar.items?[0].image = UIImage(named: "home")
        tabBarController.tabBar.items?[0].title = StringLiteral.TabBar.homeTitle
        tabBarController.tabBar.items?[1].image = UIImage(named: "search")
        tabBarController.tabBar.items?[1].title = StringLiteral.TabBar.searchTitle
        tabBarController.tabBar.items?[2].image = UIImage(named: "tabBarPosition")
        tabBarController.tabBar.items?[2].title = StringLiteral.TabBar.nearByTitle
        tabBarController.tabBar.items?[3].image = UIImage(named: "like")
        tabBarController.tabBar.items?[3].title = StringLiteral.TabBar.likeTitle
        tabBarController.tabBar.items?[4].image = UIImage(named: "my")
        tabBarController.tabBar.items?[4].title = StringLiteral.TabBar.myInfoTitle
        
        tabBarController.tabBar.tintColor = UIColor.brandColor(brightness: .Brand)
        tabBarController.selectedIndex = 1
        return tabBarController
    }
    
}
