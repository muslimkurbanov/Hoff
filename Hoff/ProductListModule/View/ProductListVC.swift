//
//  ProductListViewController.swift
//  Hoff
//
//  Created by Муслим Курбанов on 22.01.2021.
//

import UIKit

//MARK: - Protocols
protocol ProductListViewProtocol: class {
    func success()
    func failure(error: Error)
    func scrollToTop()
}

class ProductListVC: UIViewController {
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    private let cartManager = AddToFavoriteManager.shared
    private let refreshControl = UIRefreshControl()
    var presenter: ViewPresetnerProtocol!
    var offset = 1
    var limit = 20

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        productListCVSettings()
        presenter.getProducts(id: 0, offset: "0", limit: "20")
    }
    
    //MARK: - IBActions
    @IBAction func showFilterVC(_ sender: Any) {
        let vc = SortVC()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.delegate = presenter
        self.present(vc, animated: true, completion: nil)
    }
    //MARK: - ProductListSettings
    private func productListCVSettings() {
        self.productListCollectionView.alwaysBounceVertical = true
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
    }
    
    
}

extension ProductListVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        SortVCPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

//MARK: - ProductListViewProtocol
extension ProductListVC: ProductListViewProtocol {
    func scrollToTop() {
        limit = 20
        self.productListCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
    }
    func success() {
        productListCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - DataSource
extension ProductListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductListCollectionViewCell
        let item = presenter.items[indexPath.row]
        let isLiked = cartManager.addToFavoriteProduct(Int(item.id) ?? 0)
        cellA.configurate(with: item, isLiked)
        return cellA
    }
    
}

//MARK: - Delegate
extension ProductListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let id = indexPath.item == (presenter.items.count) - 1
        print(indexPath.item)
        if id {
            limit += 20
            presenter.getProducts(id: 0, offset: "0", limit: "\(limit)")
        }
    }
}

