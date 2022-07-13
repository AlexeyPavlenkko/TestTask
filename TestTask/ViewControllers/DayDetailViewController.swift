//
//  DayDetailViewController.swift
//  TestTask
//
//  Created by Алексей Павленко on 07.07.2022.
//

import UIKit

private let cellReuseIdentifier = "DayDetailView"

class DayDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        updateNavTitle()
    }
    
    var category: CategoryViewModel!
    var personnelInfo: PersonnelLoss?
    var equipmentInfo: EquipmentLoss?
    
 
    func updateNavTitle() {
        switch category {
        case .personnel:
            guard let personnelInfo = personnelInfo else {return}
            title = "Day \(personnelInfo.dayOfWar) (\(personnelInfo.date.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits))))"
        default:
            guard let equipmentInfo = equipmentInfo else {return}
            title = "Day \(equipmentInfo.dayOfWar) (\(equipmentInfo.date.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits))))"
        }
    }
}

//MARK: - TableView Data Source
extension DayDetailViewController: UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        switch category {
        case .total:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category {
        case .personnel:
            return PersonnelLoss.Unit.allCases.count
        case .equipment:
            return EquipmentLoss.Unit.allCases.count
        default:
            if section == 0 {
                return PersonnelLoss.Unit.allCases.count
            } else {
                return EquipmentLoss.Unit.allCases.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()
        
        switch category {
        case .personnel:
            guard let personnelInfo = personnelInfo else {return cell}
            let personnelLossUnitCase = PersonnelLoss.Unit.allCases[indexPath.row]
            
            content.text = personnelLossUnitCase.title + ":"
            content.secondaryText = personnelLossUnitCase.countValue(personnelInfo)
        case .equipment:
            guard let equipmentInfo = equipmentInfo else {return cell}
            let equipmentLossUnitCase = EquipmentLoss.Unit.allCases[indexPath.row]
            
            content.text = equipmentLossUnitCase.title + ":"
            content.secondaryText = equipmentLossUnitCase.countValue(equipmentInfo)
        default:
            guard let equipmentInfo = equipmentInfo, let personnelInfo = personnelInfo else {return cell}
            
            if indexPath.section == 0 {
                let personnelLossUnitCase = PersonnelLoss.Unit.allCases[indexPath.row]
                content.text = personnelLossUnitCase.title + ":"
                content.secondaryText = personnelLossUnitCase.countValue(personnelInfo)
            } else {
                let equipmentLossUnitCase = EquipmentLoss.Unit.allCases[indexPath.row]
                content.text = equipmentLossUnitCase.title + ":"
                content.secondaryText = equipmentLossUnitCase.countValue(equipmentInfo)
            }
        }
        
        content.textProperties.color = .secondaryBlue
        content.secondaryTextProperties.color = .mainBlue
        cell.contentConfiguration = content
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard category == .total else { return nil }
        
        if section == 0 {
            return "Personnel losses"
        } else {
            return "Equipment losses"
        }
    }
    
}

//MARK: - TableView Delegate
extension DayDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.textColor = .mainYellow
            header.tintColor = .secondaryBlue
        
    }
    
}
