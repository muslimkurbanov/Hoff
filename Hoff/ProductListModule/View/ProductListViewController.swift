//
//  ProductListViewController.swift
//  Hoff
//
//  Created by Муслим Курбанов on 22.01.2021.
//

import UIKit

protocol ProductListViewProtocol: class {
    func applyData(model: [Items])
    func failure(error: Error)

}

class ProductListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var typesOfProductCollectionView: UICollectionView!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    
    var searchResponse = [Items]() {
        didSet {
            productListCollectionView.reloadData()
        }
    }
    
    var presenter: ViewPresetnerProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainViewPresenter(view: self)

        typesOfProductCollectionView.delegate = self
        typesOfProductCollectionView.dataSource = self

        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self

        
        typesOfProductCollectionView.showsHorizontalScrollIndicator = false
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productListCollectionView {
            return searchResponse.count // Replace with count of your data for collectionViewA
            }

        return 5 // Replace with count of your data for collectionViewB
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.productListCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductListCollectionViewCell
            let item = searchResponse[indexPath.row]
            cellA.configurate(with: item)
            cellA.backgroundColor = .blue
                return cellA
            }

            else {
                let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath)
                return cellB
            }
    }
}

extension ProductListViewController: ProductListViewProtocol {
    func applyData(model: [Items]) {
        searchResponse.append(contentsOf: model)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

