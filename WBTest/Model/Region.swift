//
//  Region.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import Foundation
import UIKit

class Region:Equatable{
        
    var title:String
    var imagesURls:[String]
    var viewsCount:Int
    var isLiked:Bool = false
    
    init(title: String, imagesURls: [String], viewsCount: Int, isLiked: Bool) {
        self.title = title
        self.imagesURls = imagesURls
        self.viewsCount = viewsCount
        self.isLiked = isLiked
    }
    
    static func == (lhs: Region, rhs: Region) -> Bool {
        return lhs.title == rhs.title &&
        lhs.viewsCount == rhs.viewsCount &&
        lhs.imagesURls == rhs.imagesURls
    }
    
}


extension Region{
    static var regionsLocalStorage:[Region] = []
    static var favouritesRegionsLocalStorage:[Region] = []
}
