//
//  RecommendCollectionViewCell.swift
//  AppStoreLayout
//
//  Created by 원준연 on 2023/02/16.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 10
    }

}
