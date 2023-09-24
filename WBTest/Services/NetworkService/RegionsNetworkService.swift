//
//  RegionsNetworkService.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import Foundation

enum RegionsNetworkServiceErrors:Error{
    case unknown
}

protocol RegionsNetworkServiceProtocol{
    func getAllRegions() async throws -> RegionsJsonResponse
    func downloadPhoto(urlString:String) async -> Data?
}

class RegionsNetworkService:RegionsNetworkServiceProtocol{
    
    func getAllRegions() async throws -> RegionsJsonResponse {
        let url = URL(string: "https://vmeste.wildberries.ru/api/guide-service/v1/getBrands")!
        
        let result:RegionsJsonResponse = try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let decodedData = try? JSONDecoder().decode(RegionsJsonResponse.self, from: data ?? Data()){
                    continuation.resume(returning: decodedData)
                }else{
                    continuation.resume(throwing: RegionsNetworkServiceErrors.unknown)
                }
            }.resume()
        }
        
        return result
    }
    
    func downloadPhoto(urlString:String) async -> Data?{
        
        let url = URL(string: urlString)!
        
        let result:Data? = await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                continuation.resume(returning: data)
            }.resume()
        }
        
        return result
    }
    
    
}
