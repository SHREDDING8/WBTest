//
//  FavouritesRegionsPresenter.swift
//  WBTest
//
//  Created by SHREDDING on 24.09.2023.
//

import Foundation
import UIKit

protocol FavouritesViewProtocol:AnyObject{
    
}

protocol FavouritesRegionsPresenterProtocol:AnyObject{
    init(view:FavouritesViewProtocol, networkService:RegionsNetworkServiceProtocol)
    func getRegionsCount() -> Int
    func getRegion(index:Int) -> Region
    func getPhoto(url:String, completion: @escaping ((UIImage) -> Void) )
}

class FavouritesRegionsPresenter:FavouritesRegionsPresenterProtocol{
    weak var view:FavouritesViewProtocol?
    
    var networkService:RegionsNetworkServiceProtocol!
   
    required init(view:FavouritesViewProtocol, networkService:RegionsNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getRegionsCount() -> Int{
        return Region.favouritesRegionsLocalStorage.count
    }
    
    func getRegion(index:Int) -> Region{
        return Region.favouritesRegionsLocalStorage[index]
    }
    
    func getPhoto(url:String, completion: @escaping ((UIImage) -> Void) ){
        Task{
            if let data = await self.networkService.downloadPhoto(urlString:url){
                let image = UIImage(data: data)
                
                completion(image!)
            }
        }
    }
    
    
}
