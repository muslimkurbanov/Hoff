//
//  NetworkService.swift
//  MVPtestProject
//
//  Created by Муслим Курбанов on 22.12.2020.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func getProduct(completion: @escaping (Result<Product?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getProduct(completion: @escaping (Result<Product?, Error>) -> Void) {
        let urlString = "https://hoff.ru/api/v2/get_products_new?category_id=320&sort_by=popular&sort_type=desc&limit=40&offset=0&device_id=3a7612bcc84813b5&isAndroid=true&app_version=1.8.16&location=19&xhoff=36f40b3d665cdb9435904796172dde5e3f13aa8a%253A4630"
        
        AF.request(urlString, method: .get, parameters: nil).responseJSON { (responce) in
            switch responce.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                if let arrayDictionary = value as? [[String: Any]] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: arrayDictionary, options: .fragmentsAllowed)
                        print(data)
                        let result = try JSONDecoder().decode(Product.self, from: data)
                        completion(.success(result))
                        print(result)
                    } catch {
                            completion(.failure(error))
                            print(error)
                        }
                }
                
            }
        }
    }
}
