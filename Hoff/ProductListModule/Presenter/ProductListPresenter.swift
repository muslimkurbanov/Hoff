//
//  ProductListPresenter.swift
//  Hoff
//
//  Created by Муслим Курбанов on 22.01.2021.
//

import Foundation

protocol ViewPresetnerProtocol: class {
    init(view: ProductListViewProtocol, id: Int)
    func getMenu(id: Int)
}

final class MainViewPresenter: ViewPresetnerProtocol {
    
    private var searchResponce: Product? = nil
    private let networkService: NetworkServiceProtocol = NetworkService()
    private weak var view: ProductListViewProtocol?
    private var sortVC: SortVC?
    
    required init(view: ProductListViewProtocol, id: Int) {
        self.view = view
        self.getMenu(id: id)
    }
    
    let sortArray = ["popular", "price", "discounts"]
    
    func sirtBy(id: Int) {
        let sortBy = sortArray[id]
        getCatalog(sortBy: sortBy)
    }

    func getMenu(id: Int) {
        guard sortArray.count > 0 else { return }
        getCatalog(sortBy: sortArray[id])
//        print("again")
    }
    
    private func getCatalog(sortBy: String) {
        
        networkService.getProduct(categoryId: "320", sortBy: sortBy) { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let searchResponce):
                    
                    self.searchResponce = searchResponce
                    guard let item = searchResponce?.items else { return }
                    self.view?.applyData(model: item)
                    
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

