//
//  ViewController.swift
//  PageControl
//
//  Created by 원준연 on 2023/02/11.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var segmentControl: UnderlineSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentControl.removeBackgroundAndDivider()
        self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.segmentControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.green,
                .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
            ],
            for: .selected
        )
        
        
        
    }
    
    var pageViewController : PageViewController!
    
    var currentSegmentIndex : Int = 0 {
        didSet{
            print(currentSegmentIndex)
            segmentControl.selectedSegmentIndex = currentSegmentIndex
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "connectPage" {
            print("Connected")
            guard let vc = segue.destination as? PageViewController else { return }
            pageViewController = vc
            vc.viewController = self
            vc.completeHandler = { (result) in
                self.currentSegmentIndex = result
            }
        }
    }
    
    
    
    @IBAction func clickSegment(_ sender: UnderlineSegmentedControl) {
        
        let segmentIndex = self.segmentControl.selectedSegmentIndex
        pageViewController.setViewcontrollersFromIndex(index: segmentIndex)
//        let underlineFinalXPosition = (self.view.frame.width / CGFloat(segmentControl.numberOfSegments)) * CGFloat(segmentControl.selectedSegmentIndex)
//        print(underlineFinalXPosition)
//        UIView.animate(
//            withDuration: 0.1,
//            animations: {
//                //restorationID를 통해 underlineView의 위치 지정
//                if let underline = self.segmentControl.subviews.filter({$0.restorationIdentifier == "underbar"}).first{
//                    underline.frame.origin.x = underlineFinalXPosition
//                } else {
//                    print("cannot find underlineView")
//                }
//                
//            }
//        )
    }
}




