//
//  BannerCollectionViewCell.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Cell Identifier
    static let identifier = "BannerCollectionViewCell"
    
    // MARK: - IbOutlets
    @IBOutlet var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8.0
    }
    
    func configureCell(image: UIImage?) {
        self.bannerImageView.image = image
    }
}
