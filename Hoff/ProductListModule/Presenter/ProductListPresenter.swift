//
//  ProductListPresenter.swift
//  Hoff
//
//  Created by Муслим Курбанов on 22.01.2021.
//

import Foundation

//MARK: - Protocols
protocol ViewPresetnerProtocol: SortViewDelegate {
    var items: [Item] { get set }
    func getProducts(id: Int, offset: String, limit: String)
}

final class MainViewPresenter: ViewPresetnerProtocol {
    
    //MARK: - Variables
    var items: [Item] = []
    private var searchResponce: Product? = nil
    private let networkService: NetworkServiceProtocol = NetworkService()
    private weak var view: ProductListViewProtocol?
    private var sortVC: SortVC?
    
    required init(view: ProductListViewProtocol) {
        self.view = view
    }
    
    let sortArray = ["popular", "price", "lowprice","discounts"]
    
    //MARK: - Functions
    func getProducts(id: Int, offset: String, limit: String) {
        guard sortArray.count > 0 else { return }
        getCatalog(sortBy: sortArray[id], offset: offset, limit: limit)
        print("getManu")
    }
    
    func applyOffset(with id: Int) {
        
    }
    
    func applySort(with id: Int) {
        let sortBy = sortArray[id]
        getCatalog(sortBy: sortBy, offset: "0", limit: "20")
        view?.scrollToTop()
        
    }
    
    private func getCatalog(sortBy: String, offset: String, limit: String) {
        print("getCatalog")

        networkService.getProduct(categoryId: "320", sortBy: sortBy, offset: offset, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchResponce):
                    
                    self?.searchResponce = searchResponce
                    guard let items = searchResponce?.items else { return }
                                        
                    self?.items = items
                    self?.view?.success()
                    
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}

