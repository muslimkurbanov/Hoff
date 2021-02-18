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
    func scrollToTop(Limit: Int, title: String)
}

class ProductListVC: UIViewController {
    
    @IBOutlet weak var showFilter: UIButton!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let cartManager = AddToFavoriteManager.shared
    private let refreshControl = UIRefreshControl()
    
    var presenter: ViewPresetnerProtocol!
    var limit = 20
    
    var footerView: FooterView?
    
    var isLoading:Bool = true
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        productListCVSettings()
        presenter.getProducts(id: 0, offset: "0", limit: "20", sortType: "desc")
        activityIndicator.startAnimating()
        
        let collectionViewHeaderFooterReuseIdentifier = "loadingReusableView"
        let loadingReusableNib = UINib(nibName: "FooterView", bundle: nil)
        productListCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
    }
    
    //MARK: - IBActions
    @IBAction func showFilterAction(_ sender: Any) {
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
    
    func scrollToTop(Limit: Int, title: String) {
        productListCollectionView.isHidden = true
        productListCollectionView.reloadData()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        limit = Limit
        self.productListCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
        showFilter.setTitle("", for: .normal)
        showFilter.setTitle(title, for: .normal)
    }
    
    func success() {
        productListCollectionView.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        isLoading = false
        footerView?.footerActivityIndicator.stopAnimating()
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingReusableView", for: indexPath) as! FooterView
            footerView = aFooterView
            footerView?.backgroundColor = UIColor.red
            return aFooterView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
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
        
        if id {
            limit += 20
//            bottomActivityIndicator.isHidden = false
            isLoading = true
            footerView?.footerActivityIndicator.startAnimating()
            
//            bottomActivityIndicator.startAnimating()
            presenter.getProducts(id: Index.shared.index, offset: "0", limit: "\(limit)", sortType: Index.shared.sortType)
        }
    }
}

