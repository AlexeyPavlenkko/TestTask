//
//  PersonnelLoss.swift
//  TestTask
//
//  Created by Алексей Павленко on 04.07.2022.
//

import Foundation

struct PersonnelLoss: Decodable {
    
    enum Unit: String, CaseIterable {
        case personnelCount
        case prisonerCount
        
        var title: String {
            switch self {
            case .personnelCount:
                return "Personnel"
            case .prisonerCount:
                return "Prisoner of War"
            }
        }
        
        func countValue(_ personnel: PersonnelLoss) -> String {
            switch self {
            case .personnelCount:
                return String(personnel.personnelCount)
            case .prisonerCount:
                if let prisonerCount = personnel.prisonerCount {
                    return String(prisonerCount)
                } else {
                    return "-"
                }
            }
        }
    }
    
    let date: Date
    let dayOfWar: Int
    let personnelCount: Int
    let prisonerCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case dayOfWar = "day"
        case personnelCount = "personnel"
        case prisonerCount = "POW"
    }
}
