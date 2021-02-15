//
//  ViewController.swift
//  Hoff
//
//  Created by Муслим Курбанов on 21.01.2021.
//

import UIKit

class MainScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pushCatalogAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListVC else { return }
        let presenter = MainViewPresenter(view: vc)
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

