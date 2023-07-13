//
//  ViewController.swift
//  ScrollViewStickyHeader
//
//  Created by 원준연 on 2023/02/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var imageTop: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.scrollView.contentInsetAdjustmentBehavior = .never
        
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y :CGFloat = scrollView.contentOffset.y
        
        print("y:", y)
       
        if y > 0 {
            imageTop.constant = -y
        } else {
            imageTop.constant = 0
            //현재 이미지 비율은 69:50
//            let stretchingImageHeight = imageView.frame.height - 300
//            let stretchingRatio = stretchingImageHeight * (69 / 50)
//            imageView.transform = CGAffineTransform(
//                scaleX: 1.0 + (stretchingRatio / 100),
//                y: 1.0)
            let scale = (self.view.frame.height - scrollView.contentOffset.y * 4) / self.view.frame.height
            print(scale)
            imageView.transform = CGAffineTransform(scaleX: scale, y: 1.0)
        }
    }
}

