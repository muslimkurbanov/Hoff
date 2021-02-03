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
    @IBOutlet weak var nameOfGroupLabel: UILabel!
    
    var presenter: ViewPresetnerProtocol!
    
    let arrayOfCells = ["Кровати", "Диваны", "Шкафы", "Столы", "Стулья", "Кресла"]
    let att = ("Bag", 12)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //presenter = MainViewPresenter(view: self)

        typesOfProductCollectionView.delegate = self
        typesOfProductCollectionView.dataSource = self

        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self

        
        typesOfProductCollectionView.showsHorizontalScrollIndicator = false
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productListCollectionView {
            return searchResponse.count
        }

        return arrayOfCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.productListCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductListCollectionViewCell
            let item = searchResponse[indexPath.row]
            cellA.configurate(with: item)
            
                return cellA
            }

            else {
                let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypesOfProductCell
                let item = arrayOfCells[indexPath.row]
                cellB.label.text = item
                
                return cellB
            }
    }
    
    
}

class TypesOfProductCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
}

extension ProductListViewController: ProductListViewProtocol {
    func applyData(model: [Items]) {
        searchResponse.append(contentsOf: model)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

