//
//  CustomSegmentControl.swift
//  PageControl
//
//  Created by 원준연 on 2023/02/12.
//

import UIKit

class UnderlineSegmentedControl: UISegmentedControl {


    //underlineView 추가(autolayout이 아닌, frame을 이용하므로 layoutSubviews에서 호출
    lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 4.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.restorationIdentifier = "underbar"
        view.backgroundColor = .green
        self.addSubview(view)
        return view
    }()
    
    func removeBackgroundAndDivider() {
        let image = UIImage()
        //회색 배경과 divider를 지우는 코드
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    override func awakeFromNib() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bringSubviewToFront(underlineView)
    }
}
