//
//  FooterView.swift
//  Hoff
//
//  Created by Муслим Курбанов on 18.02.2021.
//

import UIKit

class FooterView: UICollectionReusableView {

    
    @IBOutlet weak var footerActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        footerActivityIndicator.color = .red
        footerActivityIndicator.startAnimating()
        // Initialization code
    }
    
}
