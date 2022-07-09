//
//  PersonnelLoss.swift
//  TestTask
//
//  Created by Алексей Павленко on 04.07.2022.
//

import Foundation

struct PersonnelLoss: Decodable {
    let date: Date
    let dayOfWar: Int
    let personnelCount: Int
    let prisonerCount: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case dayOfWar = "day"
        case personnelCount = "personnel"
        case prisonerCount = "POW"
    }
}
