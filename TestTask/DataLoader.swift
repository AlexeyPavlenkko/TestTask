//
//  DataLoader.swift
//  TestTask
//
//  Created by Алексей Павленко on 06.07.2022.
//

import Foundation

enum DataLoaderError: Error, LocalizedError {
    case urlNotValid
    case personnelDataNotFound
    case equipmentDataNotFound
    case equipmentDataCanNotBeFixed
    
    var errorDescription: String? {
        switch self {
        case .urlNotValid:
            return NSLocalizedString("Url for data is not valid", comment: "Error #0")
        case .personnelDataNotFound:
            return NSLocalizedString("No personnel data found from provided URL", comment: "Error #1")
        case .equipmentDataNotFound:
            return NSLocalizedString("No personnel data found from provided URL", comment: "Error #3")
        case .equipmentDataCanNotBeFixed:
            return NSLocalizedString("Equipment JSON data cannot be fixed", comment: "Error #4")
        }
    }
}

class DataLoader {
    static let shared = DataLoader()
    
    private let personnelStringURL = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"
    private let equipmentStringURL = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"

    var personnelLoss = [PersonnelLoss]()
    var equipmentLoss = [EquipmentLoss]()
    
    private let dateFormatter: DateFormatter = {
        let dateFrmt = DateFormatter()
        dateFrmt.dateFormat = "yyyy-MM-dd"
        return dateFrmt
    }()
    
    func loadPersonnelLossData() async throws {
        guard let url = URL(string: personnelStringURL) else { throw DataLoaderError.urlNotValid }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DataLoaderError.personnelDataNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        let personnelLosses = try jsonDecoder.decode([PersonnelLoss].self, from: data)
        
        self.personnelLoss = personnelLosses
    }
    
    func loadEquipmentLossData() async throws {
        guard let url = URL(string: equipmentStringURL) else { throw DataLoaderError.urlNotValid }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DataLoaderError.equipmentDataNotFound
        }
        
        guard let string = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "NaN", with: "null"),
              let fixedData = string.data(using: .utf8) else { throw DataLoaderError.equipmentDataCanNotBeFixed }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        let equipmentLosses = try jsonDecoder.decode([EquipmentLoss].self, from: fixedData)
        
        self.equipmentLoss = equipmentLosses
    }
}
