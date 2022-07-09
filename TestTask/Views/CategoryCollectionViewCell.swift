//
//  HomeCollectionViewCell.swift
//  TestTask
//
//  Created by Алексей Павленко on 06.07.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var secondaryLabel: UILabel!
    
    func configure(with model: CategoryViewModel) {
        imageView.image = UIImage(named: model.imageName)
        mainLabel.text = model.mainText
        secondaryLabel.text = model.secondaryText
    }
}
