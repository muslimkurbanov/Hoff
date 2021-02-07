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
    }

    @IBAction func buttonOne(_ sender: Any) {
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
    }
    
    @IBAction func buttonThree(_ sender: Any) {
    }
    
    
    @IBAction func pushCatalogAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController else { return }
        let presenter = MainViewPresenter(view: vc, id: Helper.shared.index)
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

