//
//  ViewController.swift
//  AppStoreLayout
//
//  Created by 원준연 on 2023/02/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = getLayout()
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bannerCell")
        collectionView.register(UINib(nibName: "RecommendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "recommendCell")
        collectionView.register(UINib(nibName: "CollectionTitleReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "titleHeader")
        collectionView.register(UINib(nibName: "CollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerView")
    }
    
    private func getLayout() -> UICollectionViewCompositionalLayout {
             UICollectionViewCompositionalLayout { (section , env) -> NSCollectionLayoutSection in
                 switch section {
                 case 0:
                     return self.bannerSection()
                 case 1:
                     return self.recommendSection()
                 case 2:
                     return self.recommendSection()
                 case 3:
                     return self.trendSection()
                 case 4:
                     return self.trendSection()
                 default:
                     return self.recommendSection()
                 }
             }
         }
     
     private func bannerSection() -> NSCollectionLayoutSection {
         
         // item
         let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  //그룹사이즈의
            heightDimension: .fractionalHeight(1.0) //그룹사이즈의
         )
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         // group
         let groupSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(0.9),  //화면에 보이는 collectionView의
             heightDimension: .fractionalHeight(0.4) //화면에 보이는 collectionView의
         )
         let group = NSCollectionLayoutGroup.horizontal(
             layoutSize: groupSize,
             subitems: [item]
         )
         group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
         
         //header
         let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
             heightDimension: .absolute(40)
         )
         let header = NSCollectionLayoutBoundarySupplementaryItem(
             layoutSize: headerSize,
             elementKind: UICollectionView.elementKindSectionHeader,
             alignment: .top
         )
         
         
         // section
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .groupPagingCentered
         section.boundarySupplementaryItems = [header]
         return section
     }
     
     private func recommendSection() -> NSCollectionLayoutSection {
         
         // item
         let itemSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .fractionalHeight(1.0 / 3.0)
         )
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom:5, trailing: 0)
         
         // group
         let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.3)
         )
         let group = NSCollectionLayoutGroup.vertical(
             layoutSize: groupSize,
             subitem: item,
             count: 3
         )
         
         group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
         
         //header
         let headerSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .absolute(40)
         )
         let header = NSCollectionLayoutBoundarySupplementaryItem(
             layoutSize: headerSize,
             elementKind: UICollectionView.elementKindSectionHeader,
             alignment: .top
         )
         
         // section
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .groupPaging
         section.boundarySupplementaryItems = [header]
         section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
         return section
     }
    
    private func trendSection() -> NSCollectionLayoutSection {
        
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 3.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom:5, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(0.9),
           heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
        
        //header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
   
     
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "titleHeader", for: indexPath) as! CollectionTitleReusableView
            
            return header
        } else if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! CollectionHeaderReusableView
            return header
        } else if indexPath.section == 2 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! CollectionHeaderReusableView
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! CollectionHeaderReusableView
            header.titleLabel.text = "요즘 대세는 이 게임"
            header.subTitleLabel.text = "최근 검색 순위가 상승했어요"
            return header
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! RecommendCollectionViewCell
            return cell
        }
    }
    


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print(y)
        if y > 0 && y < 40{
            
        } else if y < 0 && y > -80 {
            print("1")
            guard let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? CollectionTitleReusableView else { return }
            let fontSize = 25 + (-y * 0.1)
            headerView.titleLabel.font = UIFont.systemFont(ofSize: fontSize)

        } else if y >= 40 {
            
        }

    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}



