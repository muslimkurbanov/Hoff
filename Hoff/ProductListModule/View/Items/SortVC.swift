//
//  SortVC.swift
//  Hoff
//
//  Created by Муслим Курбанов on 04.02.2021.
//

import UIKit


class SortVC: UIViewController {

    var index: Int = 1
    var contr = Helper()
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    @IBAction func buttonOne(_ sender: Any) {
        Helper.shared.index = 0
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController else { return }
        let presenter = MainViewPresenter(view: vc, id: Helper.shared.index)
        vc.presenter = presenter
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
        Helper.shared.index = 1
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController else { return }
        let presenter = MainViewPresenter(view: vc, id: Helper.shared.index)
        vc.presenter = presenter
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonThree(_ sender: Any) {
        Helper.shared.index = 2
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController else { return }
        let presenter = MainViewPresenter(view: vc, id: Helper.shared.index)
        vc.presenter = presenter
        print("button 3")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonFour(_ sender: Any) {
        Helper.shared.index = 3
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController else { return }
        let presenter = MainViewPresenter(view: vc, id: Helper.shared.index)
        vc.presenter = presenter
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
