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
    
    public var cartManager = AddToFavoriteManager.shared
    public var id: Int!
    
    //MARK: - IBOutlets
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
    @IBOutlet weak var addToFavoriteImage: UIButton!
    
    var isLiked: Bool = false {
        didSet {
            toggleImage()
        }
    }
    //MARK: - IBActions
    @IBAction func addTofavoriteButton(_ sender: Any) {
        let change = cartManager.selectFavorite(by: id)
        isLiked = change
    }
    //MARK: - Functions
    func configurate(with model: Item, _ isLiked: Bool) {
        self.id = Int(model.id)
        self.isLiked = isLiked
        
        let price = model.prices["new"]! / 100
        
        productNameLabel.text = model.name
        productImageView?.sd_setImage(with: URL(string: model.image), completed: nil)
        isBestPriceLabel.isHidden = !model.isBestPrice
        priceLabel.text = "\(model.prices["new"]?.formattedWithSeparator ?? "") ₽"
        oldPriceLabbel.text = "\(model.prices["old"]?.formattedWithSeparator ?? "") ₽"
        
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
    
    func toggleImage() {
        let imageName = isLiked ? "fillHeart" : "heart"
        addToFavoriteImage.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
