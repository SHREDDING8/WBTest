//
//  RegionsJsonStructs.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import Foundation

// MARK: - Welcome
struct RegionsJsonResponse: Codable {
    let brands: [Brand]
}

// MARK: - Brand
struct Brand: Codable {
    let brandID, title: String
    let thumbUrls: [String]
    let tagIDS: [String]
    let slug, type: String
    let viewsCount: Int

    enum CodingKeys: String, CodingKey {
        case brandID = "brandId"
        case title, thumbUrls
        case tagIDS = "tagIds"
        case slug, type, viewsCount
    }
}
