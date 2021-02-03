//
//  ProductListCollectionViewCell.swift
//  Hoff
//
//  Created by Муслим Курбанов on 23.01.2021.
//

import UIKit
import SDWebImage
import Cosmos

class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var oldPriceLabbel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lineImageView: UIImageView!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var isBestPriceLabel: UILabel!
    
    
    @IBAction func addTofavoriteButton(_ sender: Any) {
        
    }
    
    
    func configurate(with model: Items) {
        productNameLabel.text = model.name
        productImageView?.sd_setImage(with: URL(string: model.image), completed: nil)
//        numberOfViewsLabel.text = "(" + model.numberOfReviews! + ")"
        isBestPriceLabel.isHidden = !model.isBestPrice
        
        let price = model.prices["new"]! / 100
        
        priceLabel.text = "\(model.prices["new"] ?? 0)"
        oldPriceLabbel.text = "\(model.prices["old"] ?? 0)"
        
        if model.prices["new"] == model.prices["old"] {
            oldPriceLabbel.isHidden = true
            lineImageView.isHidden = true
        } else { oldPriceLabbel.isHidden = false; lineImageView.isHidden = false }
        
        saleLabel.text = "\(model.prices["old"]! / price) %"
        saleLabel.text?.remove(at: oldPriceLabbel.text!.startIndex)
        
        if saleLabel.text == "00 %" {
            saleLabel.isHidden = true
        } else { saleLabel.isHidden = false }
        statusLabel.text = model.statusText
        ratingView.rating = Double(model.rating)
    }
}
