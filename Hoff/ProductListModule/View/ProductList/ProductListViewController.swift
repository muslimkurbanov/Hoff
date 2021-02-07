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
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    var searchResponse = [Items]() {
        didSet {
            productListCollectionView.reloadData()
        }
    }
    
    var myView: ItemsView?
    var presenter: ViewPresetnerProtocol!
    private let cartManager = AddToFavoriteManager.shared
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productListCVSettings()
    }
    
    func productListCVSettings() {
        self.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.productListCollectionView.alwaysBounceVertical = true
        self.productListCollectionView.refreshControl = refreshControl
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
    }
    
    @objc func loadData() {
        viewDidLoad()
        self.productListCollectionView.refreshControl?.beginRefreshing()
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController else { return }
        let presenter = MainViewPresenter(view: vc, id: Helper.shared.index)
        vc.presenter = presenter
        viewDidLoad()
        self.productListCollectionView.reloadData()
        stop()
    }
    func stop() {
        self.productListCollectionView!.refreshControl?.endRefreshing()
    }
    
    @IBAction func showFilterVC(_ sender: Any) {
        let vc = SortVC()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return searchResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductListCollectionViewCell
        let item = searchResponse[indexPath.row]
        let isLiked = cartManager.addToFavoriteProduct(Int(item.id) ?? 0)
        cellA.configurate(with: item, isLiked)
        return cellA
    }
}

extension ProductListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        SortVCPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


extension ProductListViewController: ProductListViewProtocol {
    func applyData(model: [Items]) {
        searchResponse.append(contentsOf: model)
        productListCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

