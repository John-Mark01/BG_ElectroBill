//
//  ResultViewControler.swift
//  Електро Сметка
//
//  Created by John-Mark Iliev on 17.11.23.
//

import UIKit
import RealmSwift

class ResultViewControler: ViewController {
    
    var bill: TableViewPopulation?
    
    var dataArray = [TableViewPopulation]()
    
    let realm = try! Realm()

    
    //MARK: - Top View
    
    @IBOutlet weak var pricePerDayLabel: UILabel!
    
    @IBOutlet weak var pricePerWeekLabel: UILabel!
    
    @IBOutlet weak var pricePerMonthLabel: UILabel!
    
    //MARK: - Bottom View
    
    @IBOutlet weak var aplienceName: UILabel!
    
    @IBOutlet weak var consumptionPerHour: UILabel!
    
    @IBOutlet weak var worktimePerDay: UILabel!
    
    @IBOutlet weak var priceForkWh: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var kWh: Double?
    var timePH: Double?
    var pricePH: Double?
    var nameForApplience: String?
    
    
    var totalPerDay: Double?
    var totalPerWeek: Double?
    var totalPerMonth: Double?
    
    var convertedTitle: String?
    var convertedPrice: String?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabels()
        
    }
    
    func updateLabels() {
        
        pricePerDayLabel.text = String(format: "%.2f лв", totalPerDay ?? "Error")
        pricePerWeekLabel.text = String(format: "%.2f лв", totalPerWeek ?? "Error")
        pricePerMonthLabel.text = String(format: "%.2f лв", totalPerMonth ?? "Error")
        
        convertedPrice = String(format: "%.2f лв", totalPerMonth ?? "Error")
        
        if kWh ?? 0 < 10 {
            consumptionPerHour.text = String(format: "%.0f кВт/ч", kWh ?? "Error")
        } else {
            consumptionPerHour.text = String(format: "%.0f ват/ч", kWh ?? "Error")
        }
        
        worktimePerDay.text = String(format: "%.0f час/а", timePH ?? "Error")
        priceForkWh.text = String(format: "%.2f лв", pricePH ?? "Error")
        
        aplienceName.text = nameForApplience
        convertedTitle = nameForApplience ?? "FailedTitle"
        
    }
    
    
    
    @IBAction func savedButtonPressed(_ sender: UIButton) {
        
        let newItem = TableViewPopulation()
        newItem.aplienceTitle = aplienceName.text ?? "Fail"
        newItem.price = String(format: "%.2f", totalPerMonth ?? "Error")
        
        
        try! realm.write {
            realm.add(newItem)
        }
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
}
