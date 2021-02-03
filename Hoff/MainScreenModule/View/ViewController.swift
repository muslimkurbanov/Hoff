//
//  ViewController.swift
//  Hoff
//
//  Created by Муслим Курбанов on 21.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pushCatalogAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController else { return }
        let presenter = MainViewPresenter(view: vc)
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

