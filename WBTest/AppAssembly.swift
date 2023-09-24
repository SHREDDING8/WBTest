//
//  AppAssembly.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import Foundation
import UIKit

protocol AppAssemblyProtocol{
    static func createMainTabBar() -> UIViewController
    static func createRegionsController() -> UIViewController
    static func  createRegionDetailController(region:Region) -> UIViewController
    static func createFavouritesController() -> UIViewController
}

class AppAssembly:AppAssemblyProtocol{
    static func createMainTabBar() -> UIViewController{
        let vc = MainTabBarController()
        return vc
    }
    
    static func createRegionsController() -> UIViewController {
        let vc = RegionsTableViewController()
        
        let networkService = RegionsNetworkService()
        let presenter = RegionsPresenter(view: vc, networkService: networkService)
        vc.presenter = presenter
        
        return BaseNavigationController(rootViewController: vc)
    }
    
    static func createRegionDetailController(region:Region) -> UIViewController {
        let vc = DetailViewController()
        vc.hidesBottomBarWhenPushed = true
        
        let networkService = RegionsNetworkService()
        
        let presenter = DetailPresenter(view: vc, region: region, networkService: networkService)
        vc.presenter = presenter
        return vc
    }
    
    static func createFavouritesController() -> UIViewController {
        let vc = FavouritesViewController()
        let networkService = RegionsNetworkService()
        let presenter = FavouritesRegionsPresenter(view: vc, networkService: networkService)
        vc.presenter = presenter
        return BaseNavigationController(rootViewController: vc)
    }
    
}
