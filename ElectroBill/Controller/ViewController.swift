//
//  ViewController.swift
//  Електро Сметка
//
//  Created by John-Mark Iliev on 14.11.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var perHourTextField: UITextField!
    
    @IBOutlet weak var segmentSwitcher: UISegmentedControl!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var applienceType: UITextField!
    
    @IBOutlet weak var moneyPerHourTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    
    
    
    var calculations = Calculations()
    
    var powerPerHour: Double?
    var timePerHour: Double?
    var pricePerHour: Double?
    
    var priceForWatt = 0.0
    var priceForKwH = 0.0
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
    }
    
    
    
    @IBAction func calculatePressed(_ sender: UIButton)  {
        
        powerPerHour = Double(perHourTextField.text ?? "perHour ERROR") ?? 0.0
        timePerHour = Double(timeTextField.text ?? "time ERROR") ?? 0.0
        pricePerHour = Double(moneyPerHourTextField.text ?? "money per hour ERROR") ?? 0.0
        
        
        switch segmentSwitcher.selectedSegmentIndex {
        case 0:
            calculations.calculateKWhPrice(kWh: powerPerHour ?? 0, price: pricePerHour ?? 0, timeUsed: timePerHour ?? 0)
            priceForKwH = calculations.getResultPerDay()
            print(priceForKwH)
            
            break
        case 1:
            calculations.convertWattsInKWH(watts: powerPerHour ?? 0, timeUsed: timePerHour ?? 0, price: pricePerHour ?? 0)
            priceForWatt = calculations.getResultForWatts()
            print(priceForWatt)
            
            break
            
        default:
            print("error in segment for: Calculate Pressed")
            
            break
        }
        
        self.performSegue(withIdentifier: "resultController", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultController" {
            let destinationViewController = segue.destination as! ResultViewControler
            switch segmentSwitcher.selectedSegmentIndex {
            case 0:
                // Top View - Calculations
                
                destinationViewController.totalPerDay = calculations.getResultPerDay()
                destinationViewController.totalPerWeek = calculations.getResultPerWeek()
                destinationViewController.totalPerMonth = calculations.getResultPerMonth()
                
                // Bottom View - Information
                
                destinationViewController.kWh = powerPerHour
                destinationViewController.timePH = timePerHour
                destinationViewController.pricePH = pricePerHour
                destinationViewController.nameForApplience = applienceType.text ?? "Error"
                break
                
            case 1:
                // Top View - Calculations
                destinationViewController.totalPerDay = calculations.getResultForWatts()
                destinationViewController.totalPerWeek = calculations.getResultForWattsPerWeek()
                destinationViewController.totalPerMonth = calculations.getResultForWattsPerMonth()
                
                // Bottom View - Information
                destinationViewController.kWh = powerPerHour
                destinationViewController.timePH = timePerHour
                destinationViewController.pricePH = pricePerHour
                destinationViewController.nameForApplience = applienceType.text ?? "Error"
                break
                
            default:
                print("Error in Prepare for Segue")
            }
              
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        
    }
}

//MARK: - UITextField Delegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        print("began Editing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ended Editing")
    }

    
}




