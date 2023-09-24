//
//  DetailPresenter.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import Foundation
import UIKit

protocol DetailViewProtocol:AnyObject{
    
}

protocol DetailPresenterProtocol:AnyObject{
    init(view:DetailViewProtocol, region:Region, networkService:RegionsNetworkServiceProtocol)
    var region:Region! { get }
    
    func loadPhoto(url:String, completion: @escaping ((UIImage) -> Void))
}
class DetailPresenter:DetailPresenterProtocol{
    weak var view:DetailViewProtocol?
    
    var region:Region!
    var networkService:RegionsNetworkServiceProtocol!
    
    required init(view:DetailViewProtocol, region:Region, networkService:RegionsNetworkServiceProtocol) {
        self.view = view
        self.region = region
        self.networkService = networkService
    }
    func loadPhoto(url:String, completion: @escaping ((UIImage) -> Void)){
        Task{
            if let data = await self.networkService.downloadPhoto(urlString:url){
                let image = UIImage(data: data)
                
                completion(image!)
            }
        }
    }
}
