//
//  FoodItemTableViewCell.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {

    // MARK: - Cell Identifier
    static let identifier = "FoodItemTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var foodDescriptionLabel: UILabel!
    @IBOutlet var foodPriceLabel: UILabel!
    
    // MARK: - Properties
    var visualEffectView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.foodImageView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // configure cell
    func configureCell(foodItem: Food?) {
        self.foodNameLabel.text = foodItem?.foodName
        self.foodDescriptionLabel.text = foodItem?.ingridents
        self.foodPriceLabel.text = "Rs \(foodItem?.price ?? 0)"
        if let foodName = foodItem?.foodName?.lowercased(), let foodImage = UIImage(named: foodName) {
            self.foodImageView.image = foodImage
        } else {
            self.foodImageView.image = #imageLiteral(resourceName: "pizza-thumbnail")
        }
        
        self.IsBlurredImage(foodItem?.isSelected ?? false)
    }
    
    // handle toggle blur for image view
    func IsBlurredImage(_ isBlurred: Bool) {
            if isBlurred {
                if self.visualEffectView == nil {
                    let blurEffect = UIBlurEffect(style: .prominent)
                    let visualEffectView = UIVisualEffectView(effect: blurEffect)

                    visualEffectView.frame = self.foodImageView.bounds

                    self.foodImageView.addSubview(visualEffectView)
                    self.contentView.clipsToBounds = true

                    self.visualEffectView = visualEffectView
                }
            } else {
                self.visualEffectView?.removeFromSuperview()
                self.visualEffectView = nil
            }
        }
}
