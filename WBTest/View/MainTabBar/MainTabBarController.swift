//
//  MainTabBarController.swift
//  WBTest
//
//  Created by SHREDDING on 24.09.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let regionsController = AppAssembly.createRegionsController()
        regionsController.tabBarItem = UITabBarItem(title: "Регионы", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        
        let favourites = AppAssembly.createFavouritesController()
        favourites.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        self.setViewControllers([regionsController, favourites], animated: true)
        
    }
    
}
