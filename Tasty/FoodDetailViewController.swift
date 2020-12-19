//
//  FoodDetailViewController.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

class FoodDetailViewController: UIViewController {

    // Method for initializing this view controller
    class func initiateViewController() -> FoodDetailViewController {
        guard let foodDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FoodDetailViewController") as? FoodDetailViewController else {
            return FoodDetailViewController()
        }
        return foodDetailViewController
    }
    
    // MARK: - IBOutlets
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var foodDescriptionLabel: UILabel!
    @IBOutlet var ratingsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var selectedButton: UIButton!
    @IBOutlet var foodImageView: UIImageView!
    
    // MARK: - Properties
    var foodItem: Food?
    var selectedButtonCompletionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "FOOD DETAILS"
        self.setFoodData()
        self.toggleSelectedButton()
    }

    // Set Inital Data
    func setFoodData() {
        self.foodNameLabel.text = foodItem?.foodName
        self.foodDescriptionLabel.text = foodItem?.ingridents
        self.priceLabel.text = "Rs \(foodItem?.price ?? 0)"
        self.ratingsLabel.text = "RATING \(foodItem?.rating ?? 0)"
        self.selectedButton.isSelected = foodItem?.isSelected ?? false
        if let foodName = foodItem?.foodName?.lowercased(), let foodImage = UIImage(named: foodName) {
            self.foodImageView.image = foodImage
        } else {
            self.foodImageView.image = #imageLiteral(resourceName: "pizza-thumbnail")
        }
    }
    
    // Handle toggle on selected button tapped
    private func toggleSelectedButton() {
        if selectedButton.isSelected {
            self.selectedButton.fillTheme()
            self.selectedButton.setTitle("SELECTED", for: .selected)
        } else {
            self.selectedButton.borderedTheme()
            self.selectedButton.setTitle("PLEASE SELECT", for: .normal)
        }
    }
    
    // MARK: - IBActions
    
    // Handle selected button tapped
    @IBAction func selectedButtonTapped(_ sender: UIButton) {
        self.selectedButton.isSelected = !selectedButton.isSelected
        
        UIView.animate(withDuration: 0.5) {
            self.toggleSelectedButton()
        } completion: { (_) in
            self.selectedButtonCompletionHandler?(self.selectedButton.isSelected)
            self.navigationController?.popViewController(animated: true)

        }

    }
}
