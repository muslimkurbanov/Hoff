//
//  SortVC.swift
//  Hoff
//
//  Created by Муслим Курбанов on 04.02.2021.
//

import UIKit

//MARK: - Protocols
protocol SortViewDelegate: class {
    func applySort(id: Int, title: String)
}

final class SortVC: UIViewController {
    
    weak var delegate: SortViewDelegate?
    weak var update: ProductListViewProtocol?
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBOutlet weak var fourthButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    // MARK: - IBActions
    @IBAction private func buttonOne(_ sender: Any) {
        dismiss(animated: true) {
            Index.shared.index = 0
            Index.shared.sortType = "desc"
            self.delegate?.applySort(id: 0, title: self.firstButton.title(for: .normal) ?? "")
        }
    }
    
    @IBAction private func buttonTwo(_ sender: Any) {
        dismiss(animated: true) {
            Index.shared.index = 1
            Index.shared.sortType = "asc"
            self.delegate?.applySort(id: 1, title: self.secondButton.title(for: .normal) ?? "")
        }
        
    }
    
    @IBAction private func buttonThree(_ sender: Any) {
        dismiss(animated: true) {
            Index.shared.index = 2
            Index.shared.sortType = "desc"
            self.delegate?.applySort(id: 2, title: self.thirdButton.title(for: .normal) ?? "")
        }
    }
    
    @IBAction private func buttonFour(_ sender: Any) {
        dismiss(animated: true) {
            Index.shared.index = 3
            Index.shared.sortType = "desc"
            self.delegate?.applySort(id: 3, title: self.fourthButton.title(for: .normal) ?? "")
        }
    }
    
    
    // MARK: - Private funcs
    
    @objc private func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
