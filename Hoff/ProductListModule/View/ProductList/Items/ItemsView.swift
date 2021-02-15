//
//  ItemsView.swift
//  Hoff
//
//  Created by Муслим Курбанов on 03.02.2021.
//

import UIKit

class ItemsView: UIView {
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    let arrayOfCells = ["Кровати", "Диваны", "Шкафы", "Столы", "Стулья", "Кресла"]
            
    override func draw(_ rect: CGRect) {
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        itemsCollectionView.showsHorizontalScrollIndicator = false
    }

    @IBAction func test(sender: Any) {
        
    }
}

extension ItemsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypesOfProductCell
        cell.typeNameLabel.text = arrayOfCells[indexPath.row]
        return cell
    }
}

