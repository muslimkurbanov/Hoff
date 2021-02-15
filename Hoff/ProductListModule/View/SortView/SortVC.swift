//
//  SortVC.swift
//  Hoff
//
//  Created by Муслим Курбанов on 04.02.2021.
//

import UIKit

//MARK: - Protocols
protocol SortViewDelegate: class {
    func applySort(with id: Int)
}

final class SortVC: UIViewController {
    
    weak var delegate: SortViewDelegate?
    weak var update: ProductListViewProtocol?
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    
    
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
            
            self.delegate?.applySort(with: 0)
        }
    }
    
    @IBAction private func buttonTwo(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.applySort(with: 1)
        }
        
    }
    
    @IBAction private func buttonThree(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.applySort(with: 2)
        }
    }
    
    @IBAction private func buttonFour(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.applySort(with: 3)
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
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
