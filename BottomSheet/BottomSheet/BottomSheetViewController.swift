//
//  BottomSheetViewController.swift
//  BottomSheet
//
//  Created by 원준연 on 2023/03/06.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var bottomSheetView: UIView!
    
 
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundView: UIView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomSheetView.clipsToBounds = true
        bottomSheetView.layer.cornerRadius = 20
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
        let backgroundViewTapped = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped(_:)))
        backgroundView.addGestureRecognizer(backgroundViewTapped)
        backgroundView.isUserInteractionEnabled = true
    }
    
    private func showBottomSheet() {
        bottomSheetHeight.constant = 500
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 0.7
            self.view.layoutIfNeeded()
           }, completion: nil)
    }
    
    private func hideBottomSheetAndGoBack() {
        bottomSheetHeight.constant = 50
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
               self.backgroundView.alpha = 0.0
               self.view.layoutIfNeeded()
           }) { _ in
               if self.presentingViewController != nil {
                   self.dismiss(animated: false, completion: nil)
               }
           }
        
    }
    
    @objc private func backgroundViewTapped(_ sender: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
}
