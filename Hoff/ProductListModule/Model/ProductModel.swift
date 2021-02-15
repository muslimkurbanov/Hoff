//
//  ProductModel.swift
//  Hoff
//
//  Created by Муслим Курбанов on 22.01.2021.
//

import Foundation

struct Product: Decodable {
    var items: [Item]
}
struct Item: Decodable {
    var name: String
    var id: String
    var image: String
    var isFavorite: Bool
    var prices: [URLKing.RawValue:Int]
    var statusText: String?
    var rating: Int
    var isBestPrice: Bool
}
enum URLKing: String {
    case new
    case old
}
