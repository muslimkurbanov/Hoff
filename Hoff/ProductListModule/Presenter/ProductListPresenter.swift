//
//  ProductListPresenter.swift
//  Hoff
//
//  Created by Муслим Курбанов on 22.01.2021.
//

import Foundation

protocol ViewPresetnerProtocol: class {
    init(view: ProductListViewProtocol)
    func getMenu()
}

final class MainViewPresenter: ViewPresetnerProtocol {
    
    private var searchResponce: Product? = nil

    private let networkService: NetworkServiceProtocol = NetworkService()
    
    private weak var view: ProductListViewProtocol?
    
    required init(view: ProductListViewProtocol) {
        self.view = view
        self.getMenu()
    }
    
    
    let sortArray = ["popular", "price"]
    
    func sirtBy(id: Int) {
        let sortBy = sortArray[id]
        getCatalog(sortBy: sortBy)
    }

    func getMenu() {
        guard sortArray.count > 0 else { return }
        getCatalog(sortBy: sortArray[0])
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

