//
//  ProductListUserSettings.swift
//  Hoff
//
//  Created by Муслим Курбанов on 05.02.2021.
//

import Foundation

class AddToFavoriteManager {
    static let shared = AddToFavoriteManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let menuKey = "LIKE_PRODUCT"
    
    var productIds: [Int] {
        let array  = defaults.object(forKey: menuKey) as? [Int]
        return array ?? []
    }
    
    func addToFavoriteProduct(_ id: Int) -> Bool {
        return productIds.contains(id)
    }
    
    func selectFavorite(by id: Int) -> Bool {
        var added: Bool
        var productsCopy = productIds
        
        if productsCopy.contains(id), let index = productsCopy.firstIndex(of: id) {
            productsCopy.remove(at: index)
            added = false
        } else {
            productsCopy.append(id)
            added = true
        }
        defaults.set(productsCopy, forKey: menuKey)
        return added
    }
    
    
}
