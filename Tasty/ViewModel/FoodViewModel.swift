//
//  FoodViewModel.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

class FoodViewModel {
    
    // MARK: - Properties
    var foodMenu: [FoodMenu] = []
    var banners: [UIImage] = []
    
    // parsing JSON for dummy data
    func parseJSON(completionHandler: ((Bool)->Void)) {
        if let path = Bundle.main.path(forResource: "FoodMenu", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.foodMenu = try JSONDecoder().decode([FoodMenu].self, from: data)
                debugPrint(foodMenu.count)
                completionHandler(true)
            } catch {
                // handle error
                debugPrint("JSON Parsing error")
                completionHandler(false)
            }
        }
    }
    
    // getting dummy banner images
    func getBannerData(completionHandler: ((Bool)->Void)) {
        for index in 1..<5 {
            if let foodImage = UIImage(named: "banner-\(index)") {
                self.banners.append(foodImage)
            }
        }
        completionHandler(true)
    }
}
