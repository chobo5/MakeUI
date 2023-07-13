//
//  ViewController.swift
//  BottomSheet
//
//  Created by 원준연 on 2023/03/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        guard let bottomSheetVC = storyboard?.instantiateViewController(withIdentifier: "bottomSheet") as? BottomSheetViewController else { return }
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)
    }
    
}

