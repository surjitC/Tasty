//
//  FoodMenuModel.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import Foundation

// MARK: - FoodMenu
struct FoodMenu: Codable {
    let categoryID: Int?
    let categoryName: String?
    var items: [Food]?
}

// MARK: - Food
struct Food: Codable {
    let foodID: Int?
    let foodName, ingridents: String?
    let rating: Double?
    let price: Int?
    var isSelected: Bool?
}
