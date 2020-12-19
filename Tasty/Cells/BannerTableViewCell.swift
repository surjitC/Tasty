//
//  BannerTableViewCell.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    // MARK: - Cell Identifier
    static let identifier = "BannerTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: FoodViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // configure cell
    func configureCell(viewModel: FoodViewModel) {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.viewModel = viewModel
    }

}

// MARK: - BannerTableViewCell Collection View Extensions
extension BannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.banners.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell  else {
            preconditionFailure("Failed to load cell")
        }
        let banner = viewModel?.banners[indexPath.row]
        bannerCell.configureCell(image: banner)
        return bannerCell
    }
}

extension BannerTableViewCell: UICollectionViewDelegate {
    
}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.size.width * 0.8
        let height = self.frame.size.height - 20
        
        return CGSize(width: width, height: height)
        
    }
}
