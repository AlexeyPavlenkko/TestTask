//
//  HomeViewModel.swift
//  TestTask
//
//  Created by Алексей Павленко on 05.07.2022.
//

import Foundation

enum CategoryViewModel: String, CaseIterable {
    case personnel
    case equipment
    case total
    
    var mainText: String {
        "\(rawValue.capitalized) losses"
    }
    
    var secondaryText: String {
        "Tap to see russian's \(rawValue) losses during invasion in Ukraine"
    }
    
    var imageName: String {
        rawValue
    }
    
}
