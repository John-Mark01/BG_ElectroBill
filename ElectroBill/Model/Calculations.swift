//  Created by John-Mark Iliev on 17.11.23.
//

import Foundation

struct ElectricityPower {
    
        var kWh: Double

}

struct Calculations {
        
    
    var pricePerKWh: ElectricityPower?
    var pricePerWatts: Double?
    
    mutating func calculateKWhPrice(kWh: Double, price: Double, timeUsed: Double) {
        let result = (kWh * timeUsed) * price
        pricePerKWh = ElectricityPower(kWh: result)
    }
    mutating func convertWattsInKWH(watts: Double, timeUsed: Double, price: Double) {
        let convertedKWH = ((watts * timeUsed) / 1000) * price
        pricePerWatts = convertedKWH
    }
 
    
    //MARK: - KwH
    func getResultPerDay() -> Double {
        return pricePerKWh?.kWh ?? 0.0
    }
    
    func getResultPerWeek() -> Double {
        return ((pricePerKWh?.kWh ?? 0.0) * 7)
    }
    func getResultPerMonth() -> Double {
        return ((pricePerKWh?.kWh ?? 0.0) * 30)
    }
    
    //MARK: - Watts
    
    func getResultForWatts() -> Double {
        return pricePerWatts ?? 0.0
    }
    
    func getResultForWattsPerWeek() -> Double {
        return (pricePerWatts ?? 0.0) * 7
    }
    
    func getResultForWattsPerMonth() -> Double {
        return (pricePerWatts ?? 0.0) * 30
    }
    
    
}
