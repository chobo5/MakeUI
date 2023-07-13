//
//  PageViewController.swift
//  PageControl
//
//  Created by 원준연 on 2023/02/11.
//

import UIKit

 

class PageViewController: UIPageViewController {
    
    lazy var vcArray: [UIViewController] = {
        return [
            self.vcInstance(name: "NewVC"),
            self.vcInstance(name: "MondayVC"),
            self.vcInstance(name: "TuesdayVC"),
            self.vcInstance(name: "WednesdayVC"),
            self.vcInstance(name: "ThursdayVC"),
            self.vcInstance(name: "FridayVC"),
            self.vcInstance(name: "SaturdayVC"),
            self.vcInstance(name: "SundayVC"),
            self.vcInstance(name: "EverydayVC"),
            self.vcInstance(name: "CompletedVC")
        ]
    }()
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    var currentPageIndex : Int {
        guard let vc = viewControllers?.first else { return 0 }
        return vcArray.firstIndex(of: vc) ?? 0

    }
    
    var completeHandler : ((Int)->())?
    
    var viewController = ViewController()
    
//    let underlineCustomView = UnderlineSegmentedControl()
    
    var ratio = CGFloat(0)
    var estimateOffSetX: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        // 첫 번째 페이지를 기본 페이지로 설정
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        let scrollView = view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
    }
    
    func setViewcontrollersFromIndex(index : Int){
          if index < 0 && index >= vcArray.count {return }
        self.setViewControllers([vcArray[index]], direction: .forward, animated: true, completion: nil)
        completeHandler?(currentPageIndex)
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 배열에서 현재 페이지의 컨트롤러를 찾아서 해당 인덱스를 현재 인덱스로 기록
//        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        // 이전 페이지 인덱스
        let prevIndex = currentPageIndex - 1
        
        // 인덱스가 0 이상이라면 그냥 놔둠
        guard prevIndex >= 0 else {
            // 무한반복 시 - 1페이지에서 마지막 페이지로 가야함
            return vcArray.last
        }
        
        // 인덱스는 vcArray.count 이상이 될 수 없음
        guard vcArray.count > prevIndex else { return nil }
        return vcArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
//        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        // 다음 페이지 인덱스
        let nextIndex = currentPageIndex + 1
        
        guard nextIndex < vcArray.count else {
            // 무한반복 시 - 마지막페이지에서 1 페이지로 가야함
            return vcArray.first
        }
        
        guard vcArray.count > nextIndex else { return nil }
        
        return vcArray[nextIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("willTransitionTo", pendingViewControllers)
    }
    
  
    
    
    
}

extension PageViewController: UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            completeHandler?(currentPageIndex)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let pageWidth = self.view.frame.width

        // 각각의 뷰의 위치를 변환
        for vc in vcArray {

            let pagePoint = vc.view.convert(CGPoint(), to: view)

            if pagePoint.x > CGFloat(0.0) && pagePoint.x < pageWidth {
                if let estimatePage = vcArray.firstIndex(where: {$0 == vc}) {

                    estimateOffSetX = CGFloat(estimatePage) * pageWidth - pagePoint.x


                    // 계산된 x값을 확인해보면 살짝씩 오차가 있음
                    print(estimateOffSetX)

                    if let underline = self.viewController.segmentControl.subviews.filter({$0.restorationIdentifier == "underbar"}).first{
                        underline.frame.origin.x = estimateOffSetX / 10
                    }
                }
            }
        }
    }
}
