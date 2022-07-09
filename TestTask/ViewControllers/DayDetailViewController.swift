//
//  DayDetailViewController.swift
//  TestTask
//
//  Created by Алексей Павленко on 07.07.2022.
//

import UIKit

class DayDetailViewController: UIViewController {

    // MARK: Outlelts
    //Equipment Stack View + equipment outlets
    @IBOutlet private var equipmentStackView: UIStackView!
    @IBOutlet private var aircraftNumberLable: UILabel!
    @IBOutlet private var helicopterNumberLabel: UILabel!
    @IBOutlet private var tankNumberLabel: UILabel!
    @IBOutlet private var apcNumberLabel: UILabel!
    @IBOutlet private var fieldArtilleryNUmberLabel: UILabel!
    @IBOutlet private var mrlNumberLabel: UILabel!
    @IBOutlet private var militaryAutoNumberLabel: UILabel!
    @IBOutlet private var fuelTankNumberLabel: UILabel!
    @IBOutlet private var droneNumberLabel: UILabel!
    @IBOutlet private var navalShipNumberLabel: UILabel!
    @IBOutlet private var antiaAircraftSystemNUmberLabel: UILabel!
    @IBOutlet private var specialEquipmentNumberLabel: UILabel!
    @IBOutlet private var mobileSRBMNumberLabel: UILabel!
    @IBOutlet private var vehiclesFuelTanksNumberLabel: UILabel!
    @IBOutlet private var cruiseMIssilesNumberLabel: UILabel!
    
    //Personnel Stack View + personnel outlets
    @IBOutlet private var personnelInfoStackView: UIStackView!
    @IBOutlet private var personnelNumberLabel: UILabel!
    @IBOutlet private var prisonerNumberLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    var personnelInfo: PersonnelLoss?
    var equipmentInfo: EquipmentLoss?
    

    private func updateUI() {
        equipmentStackView.isHidden = true
        personnelInfoStackView.isHidden = true
        
        if let equipmentInfo = equipmentInfo {
            title = "Day \(equipmentInfo.dayOfWar) (\(equipmentInfo.date.formatted(date: .abbreviated, time: .omitted)))"
            equipmentStackView.isHidden = false
            aircraftNumberLable.text = "\(equipmentInfo.aircraft)"
            helicopterNumberLabel.text = "\(equipmentInfo.helicopter)"
            tankNumberLabel.text = "\(equipmentInfo.tank)"
            apcNumberLabel.text = "\(equipmentInfo.armoredPersonnelCarrier)"
            fieldArtilleryNUmberLabel.text = "\(equipmentInfo.fieldArtillery)"
            mrlNumberLabel.text = "\(equipmentInfo.multipleRocketLauncher)"
            militaryAutoNumberLabel.text = equipmentInfo.militaryAuto != nil ? "\(equipmentInfo.militaryAuto!)" : "-"
            fuelTankNumberLabel.text = equipmentInfo.fuelTank != nil ? "\(equipmentInfo.fuelTank!)" : "-"
            droneNumberLabel.text = "\(equipmentInfo.drone)"
            navalShipNumberLabel.text = "\(equipmentInfo.navalShip)"
            antiaAircraftSystemNUmberLabel.text = "\(equipmentInfo.antiAircraftWarfare)"
            specialEquipmentNumberLabel.text = equipmentInfo.specialEquipment != nil ? "\(equipmentInfo.specialEquipment!)" : "-"
            mobileSRBMNumberLabel.text = equipmentInfo.mobileSRBMsystem != nil ? "\(equipmentInfo.mobileSRBMsystem!)" : "-"
            vehiclesFuelTanksNumberLabel.text = equipmentInfo.vehiclesAndFuelTanks != nil ? "\(equipmentInfo.vehiclesAndFuelTanks!)" : "-"
            cruiseMIssilesNumberLabel.text = equipmentInfo.cruiseMissiles != nil ? "\(equipmentInfo.cruiseMissiles!)" : "-"
        }
        
        if let personnelInfo = personnelInfo {
            title = "Day \(personnelInfo.dayOfWar) (\(personnelInfo.date.formatted(date: .abbreviated, time: .omitted)))"
            personnelInfoStackView.isHidden = false
            personnelNumberLabel.text = "\(personnelInfo.personnelCount)"
            prisonerNumberLabel.text = "\(personnelInfo.prisonerCount)"
        }
        
    }
    
    
    
    
    
    
}
