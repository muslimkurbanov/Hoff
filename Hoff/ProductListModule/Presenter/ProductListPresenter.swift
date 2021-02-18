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
    func getProducts(id: Int, offset: String, limit: String, sortType: String)
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
    
    let sortArray = ["popular", "price", "price", "discount"]
    let sortTypeArray = ["desc","asc","desc","desc"]
    let limit = 20
    
    //MARK: - Functions
    func getProducts(id: Int, offset: String, limit: String, sortType: String) {
        guard sortArray.count > 0 else { return }
        getCatalog(sortBy: sortArray[id], offset: offset, limit: limit, sortType: sortType)
    }
    
    func applyOffset(with id: Int) {
        
    }
    
    func applySort(id: Int, title: String) {
        let sortBy = sortArray[id]
        let sortType = sortTypeArray[id]
        getCatalog(sortBy: sortBy, offset: "0", limit: "20", sortType: sortType)
        view?.scrollToTop(Limit: limit, title: title)
    }
    
    private func getCatalog(sortBy: String, offset: String, limit: String, sortType: String) {
        networkService.getProduct(categoryId: "320", sortBy: sortBy, offset: offset, limit: limit, sortType: sortType) { [weak self] result in
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

