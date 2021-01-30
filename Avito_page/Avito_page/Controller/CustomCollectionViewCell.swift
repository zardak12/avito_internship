//
//  CustomCollectionViewCell.swift
//  Avito_page
//
//  Created by Марк Шнейдерман on 15.01.2021.
//

import UIKit
import Foundation

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
      //MARK: - Настройка item
    func configure(with list : Page){
        avaImageView.downloaded(from: list.imageUrl)
        nameLabel.text = list.title
        nameLabel.sizeToFit()
        additionalLabel.text = list.description
        additionalLabel.lineBreakMode = .byWordWrapping
        additionalLabel.numberOfLines = 0
        priceLabel.text = list.price
    }
}



