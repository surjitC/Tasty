//
//  ViewController.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var foodMenuTableView: UITableView!
    
    // MARK: - Properties
    private let foodViewModel = FoodViewModel()
    private var hiddenSections = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "TASTY"
        
        // adding default footer view to take up empty space if content is less than screen size
        self.foodMenuTableView.tableFooterView = UIView()
        
        // parse dummy data
        self.foodViewModel.parseJSON { [weak self] (success) in
            guard let strongSelf = self else { return }
            strongSelf.foodMenuTableView.reloadData()
        }
        self.foodViewModel.getBannerData { [weak self] (success) in
            guard let strongSelf = self else { return }
            strongSelf.foodMenuTableView.reloadSections(IndexSet(arrayLiteral: .zero), with: .automatic)
        }
    }
    
    // Methods to toggle sections
    @objc
    private func toggleSection(sender: UIButton) {
        let section = sender.tag
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.foodMenuTableView.beginUpdates()
            self.foodMenuTableView.insertRows(at: indexPathsForSection(section), with: .bottom)
            self.foodMenuTableView.endUpdates()
        } else {
            self.hiddenSections.insert(section)
            self.foodMenuTableView.beginUpdates()
            self.foodMenuTableView.deleteRows(at: indexPathsForSection(section), with: .top)
            self.foodMenuTableView.endUpdates()
        }
    }
    
    // Get the index paths for number of food items in a particular section
    func indexPathsForSection(_ section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        let itemCount = self.foodViewModel.foodMenu[section - 1].items?.count ?? 0
        for row in 0..<itemCount {
            indexPaths.append(IndexPath(row: row, section: section))
        }
        
        return indexPaths
    }
}

// MARK: - View Controller Table View Extensions
extension ViewController: UITableViewDataSource {
    private enum Sections: Int {
        case Banner
        case FoodItem
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.foodViewModel.foodMenu.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .Banner:
            return 1
        default:
            if hiddenSections.contains(section) {
                return .zero
            }
            return self.foodViewModel.foodMenu[section - 1].items?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .Banner:
            guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as? BannerTableViewCell  else {
                preconditionFailure("Failed to load cell")
            }
            bannerCell.configureCell(viewModel: self.foodViewModel)
            return bannerCell
        default:
            guard let foodItemCell = tableView.dequeueReusableCell(withIdentifier: FoodItemTableViewCell.identifier, for: indexPath) as? FoodItemTableViewCell  else {
                preconditionFailure("Failed to load cell")
            }
            
            let food = self.foodViewModel.foodMenu[indexPath.section - 1].items?[indexPath.row]
            foodItemCell.configureCell(foodItem: food)
            return foodItemCell
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // initializing detail view controller and adding proper data
        let foodDetailViewController = FoodDetailViewController.initiateViewController()
        let food = self.foodViewModel.foodMenu[indexPath.section - 1].items?[indexPath.row]
        foodDetailViewController.foodItem = food
        
        // handle response in this view controller for selected button tapped inside FoodDetailViewController
        foodDetailViewController.selectedButtonCompletionHandler = { [weak self] isSelected in
            guard let strongSelf = self else { return }
            strongSelf.foodViewModel.foodMenu[indexPath.section - 1].items?[indexPath.row].isSelected = isSelected
            strongSelf.foodMenuTableView.reloadRows(at: [indexPath], with: .none)
            
        }
        
        // navigate to FoodDetailViewController
        self.navigationController?.pushViewController(foodDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Sections.Banner == Sections(rawValue: indexPath.section) {
            // make banner 1/4 of the screen
            return tableView.frame.size.height * 0.25
        }
        // default cell size
        return 104
    }
    
    // Table view section header methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if Sections(rawValue: section) == .Banner {
            return nil
        }
        // creating button for toggling sections
        let sectionButton = UIButton()
        
        sectionButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        sectionButton.setTitleColor(.systemYellow, for: .normal)
        sectionButton.contentHorizontalAlignment = .left
        sectionButton.backgroundColor = .systemGroupedBackground
        
        let title = self.foodViewModel.foodMenu[section - 1].categoryName?.uppercased() ?? ""
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        sectionButton.setAttributedTitle(attributedString, for: .normal)
        
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(self.toggleSection(sender:)), for: .touchUpInside)
        return sectionButton
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if Sections(rawValue: section) == .Banner {
            return .zero
        }
        return 30
    }
}
