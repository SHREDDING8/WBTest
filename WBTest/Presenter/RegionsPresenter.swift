//
//  RegionsPresenter.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import Foundation
import UIKit

protocol RegionsViewProtocol:AnyObject{
    func updateRegions()
    func errorLoadRegions()
    func endRefreshing()
    
}

protocol RegionsPresenterProtocol:AnyObject{
    init(view:RegionsViewProtocol, networkService:RegionsNetworkServiceProtocol)
        
    func loadRegions()
    func getRegionsCount() -> Int
    func getRegion(index:Int) -> Region
    func getPhoto(url:String, completion: @escaping ((UIImage) -> Void) )
}

class RegionsPresenter:RegionsPresenterProtocol{
    weak var view:RegionsViewProtocol?
        
    let networkService:RegionsNetworkServiceProtocol!
    
    required init(view:RegionsViewProtocol,networkService:RegionsNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func newjJsonToModel(json:Brand) -> Region {
        
        
        let newModel = Region(title: json.title, imagesURls: json.thumbUrls, viewsCount: json.viewsCount, isLiked: false)
        
        return newModel
    }
    
    func loadRegions(){
        Task{
            do{
                let regions = try await self.networkService.getAllRegions()
                
                for region in regions.brands{
                    let newModel = self.newjJsonToModel(json: region)
                    
                    if !Region.regionsLocalStorage.contains(newModel){
                        Region.regionsLocalStorage.append(newModel)
                    }
                }
                
                DispatchQueue.main.async {
                    self.view?.updateRegions()
                    self.view?.endRefreshing()
                }
                
            } catch RegionsNetworkServiceErrors.unknown{
                print("ERROR")
                
                DispatchQueue.main.async {
                    self.view?.errorLoadRegions()
                }
            }
        }
    }
    
    func getRegionsCount() -> Int{
        return Region.regionsLocalStorage.count
    }
    func getRegion(index:Int) -> Region{
        return Region.regionsLocalStorage[index]
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
