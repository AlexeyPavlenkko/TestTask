//
//  EquipmentLoss.swift
//  TestTask
//
//  Created by Алексей Павленко on 04.07.2022.
//

import Foundation

struct EquipmentLoss: Decodable {
    
    enum Unit: String {
        case aircraft
        case helicopter
        case tank
        case armoredPersonnelCarrier
        case fieldArtillery
        case multipleRocketLauncher
        case militaryAuto
        case fuelTank
        case drone
        case navalShip
        case antiAircraftWarfare
        case specialEquipment
        case mobileSRBMsystem
        case vehiclesAndFuelTanks
        case cruiseMissiles
        
        var title: String {
            rawValue
        }
        
        var countValue: String {
            "10"
//            switch
        }
    }
    
    let date: Date
    let dayOfWar: Int
    let aircraft: Int
    let helicopter: Int
    let tank: Int
    let armoredPersonnelCarrier: Int
    let fieldArtillery: Int
    let multipleRocketLauncher: Int
    let militaryAuto: Int?
    let fuelTank: Int?
    let drone: Int
    let navalShip: Int
    let antiAircraftWarfare: Int
    let specialEquipment: Int?
    let mobileSRBMsystem: Int?
    let vehiclesAndFuelTanks: Int?
    let cruiseMissiles: Int?
    
    enum CodingKeys: String, CodingKey {
        case date
        case dayOfWar = "day"
        case aircraft
        case helicopter
        case tank
        case armoredPersonnelCarrier = "APC"
        case fieldArtillery = "field artillery"
        case multipleRocketLauncher = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMsystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        if let intDay = try? container.decode(Int.self, forKey: .dayOfWar) {
            self.dayOfWar = intDay
        } else if let stringDay = try? container.decode(String.self, forKey: .dayOfWar) {
            self.dayOfWar = Int(stringDay) ?? 0
        } else {
            self.dayOfWar = 0
        }
        self.aircraft = try container.decode(Int.self, forKey: .aircraft)
        self.helicopter = try container.decode(Int.self, forKey: .helicopter)
        self.tank = try container.decode(Int.self, forKey: .tank)
        self.armoredPersonnelCarrier = try container.decode(Int.self, forKey: .armoredPersonnelCarrier)
        self.fieldArtillery = try container.decode(Int.self, forKey: .fieldArtillery)
        self.multipleRocketLauncher = try container.decode(Int.self, forKey: .multipleRocketLauncher)
        self.militaryAuto = try? container.decode(Int.self, forKey: .militaryAuto)
        self.fuelTank = try? container.decode(Int.self, forKey: .fuelTank)
        self.drone = try container.decode(Int.self, forKey: .drone)
        self.navalShip = try container.decode(Int.self, forKey: .navalShip)
        self.antiAircraftWarfare = try container.decode(Int.self, forKey: .antiAircraftWarfare)
        self.specialEquipment = try? container.decode(Int.self, forKey: .specialEquipment)
        self.mobileSRBMsystem = try? container.decode(Int.self, forKey: .mobileSRBMsystem)
        self.vehiclesAndFuelTanks = try? container.decode(Int.self, forKey: .vehiclesAndFuelTanks)
        self.cruiseMissiles = try? container.decode(Int.self, forKey: .cruiseMissiles)
    }
}
