//
//  DataLoader.swift
//  TestTask
//
//  Created by Алексей Павленко on 06.07.2022.
//

import Foundation

class DataLoader {
    static let shared = DataLoader()
    
    init() {
        loadPersonnelData()
        loadEquipmentData()
    }
    
    var personnelLoss = [PersonnelLoss]()
    var equipmentLoss = [EquipmentLoss]()
    
    private let dateFormatter: DateFormatter = {
        let dateFrmt = DateFormatter()
        dateFrmt.dateFormat = "yyyy-MM-dd"
        return dateFrmt
    }()
    
    private func loadPersonnelData() {
        if let filePath = Bundle.main.url(forResource: "russia_losses_personnel", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: filePath)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let personnelData = try jsonDecoder.decode([PersonnelLoss].self, from: data)
                
                self.personnelLoss = personnelData
            } catch {
                print(error)
            }
        }
    }
    
    private func loadEquipmentData() {
        if let filePath = Bundle.main.url(forResource: "russia_losses_equipment", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: filePath)
                guard let string = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "NaN", with: "null"),
                      let fixedData = string.data(using: .utf8) else { return }
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let equipmentData = try jsonDecoder.decode([EquipmentLoss].self, from: fixedData)
                
                self.equipmentLoss = equipmentData
            } catch {
                print(error)
            }
        }
    }
    
}
