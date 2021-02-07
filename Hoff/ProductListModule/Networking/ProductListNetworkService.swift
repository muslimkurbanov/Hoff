//
//  NetworkService.swift
//  MVPtestProject
//
//  Created by Муслим Курбанов on 22.12.2020.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func getProduct(categoryId: String, sortBy: String, completion: @escaping (Result<Product?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getProduct(categoryId: String, sortBy: String, completion: @escaping (Result<Product?, Error>) -> Void) {
        let urlString = "https://hoff.ru/api/v2/get_products_new?sort_type=desc&limit=20&offset=0&isAndroid=true&app_version=1.8.16&location=19"
        
        var params: [String: String] = [:]
        params["category_id"] = categoryId
        params["sort_by"] = sortBy
        
        params["device_id"] = "3a7612bcc84813b5"
        
        AF.request(urlString, method: .get, parameters: params).responseJSON { (responce) in
            switch responce.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                if let arrayDictionary = value as? [String: Any] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: arrayDictionary, options: .fragmentsAllowed)
                        let result = try JSONDecoder().decode(Product.self, from: data)
                        completion(.success(result))
                    } catch {
                            completion(.failure(error))
                            print(error)
                        }
                }
                
            }
        }
    }
}
