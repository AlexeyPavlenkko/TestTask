//
//  DayListTableViewController.swift
//  TestTask
//
//  Created by Алексей Павленко on 06.07.2022.
//

import UIKit

private let reuseIdentifier = "DayCell"

class DayListTableViewController: UITableViewController {

    var category: CategoryViewModel
    let searchController = UISearchController()
    var filteredEquipmentLoss: [EquipmentLoss] = DataLoader.shared.equipmentLoss
    var filteredPersonnelLoss: [PersonnelLoss] = DataLoader.shared.personnelLoss
    
    init?(coder: NSCoder, category: CategoryViewModel) {
        self.category = category
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.mainText
        configNavigationSearchController()
    }

    private func configNavigationSearchController() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "Please enter day number"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true
    }

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category {
        case .personnel:
            return filteredPersonnelLoss.count
        default:
            return filteredEquipmentLoss.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
       
        switch category {
        case .personnel:
            let personnelLossInfo = filteredPersonnelLoss[indexPath.row]
            content.text = "Day \(personnelLossInfo.dayOfWar)"
            content.secondaryText = personnelLossInfo.date.formatted(date: .numeric, time: .omitted)
        default:
            let equipmentLossInfo = filteredEquipmentLoss[indexPath.row]
            content.text = "Day \(equipmentLossInfo.dayOfWar)"
            content.secondaryText = equipmentLossInfo.date.formatted(date: .numeric, time: .omitted)
        }

        content.textProperties.color = UIColor.secondaryBlue
        content.secondaryTextProperties.color = UIColor.mainBlue
        cell.contentConfiguration = content

        return cell
    }
    
    //MARK: - Segue
    
    @IBSegueAction func showDayDetailVC(_ coder: NSCoder, sender: Any?) -> DayDetailViewController? {
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return nil}
        
        let dayDetailVC = DayDetailViewController(coder: coder)
        dayDetailVC?.category = category
        switch category {
        case .personnel:
            dayDetailVC?.personnelInfo = filteredPersonnelLoss[indexPath.row]
            dayDetailVC?.equipmentInfo = nil
        case .equipment:
            dayDetailVC?.personnelInfo = nil
            dayDetailVC?.equipmentInfo = filteredEquipmentLoss[indexPath.row]
        case .total:
            let equipmentInformation = filteredEquipmentLoss[indexPath.row]
            guard let personnelInformation = filteredPersonnelLoss.first(where: {$0.dayOfWar == equipmentInformation.dayOfWar}) else {return nil}
            dayDetailVC?.equipmentInfo = equipmentInformation
            dayDetailVC?.personnelInfo = personnelInformation
        }
        
        return dayDetailVC
    }
    
}

//MARK: - SearchControllerDelegate
extension DayListTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        switch category {
        case .personnel:
            if !searchText.isEmpty, let searchDay = Int(searchText) {
                filteredPersonnelLoss = DataLoader.shared.personnelLoss.filter { $0.dayOfWar == searchDay}
            } else {
                filteredPersonnelLoss = DataLoader.shared.personnelLoss
            }
            tableView.reloadData()
        default:
            if !searchText.isEmpty, let searchDay = Int(searchText) {
                filteredEquipmentLoss = DataLoader.shared.equipmentLoss.filter { $0.dayOfWar == searchDay}
            } else {
                filteredEquipmentLoss = DataLoader.shared.equipmentLoss
            }
            tableView.reloadData()
        }
    }
}
