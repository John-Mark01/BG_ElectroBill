//
//  TableViewController.swift
//  ElectroBill
//
//  Created by John-Mark Iliev on 15.12.23.
//

import Foundation
import RealmSwift
import SwipeCellKit

class TableViewController: UITableViewController {

    @IBOutlet weak var totalLabel: UILabel!
    
    
    var realm = try! Realm()
    
    var items: Results<TableViewPopulation>?
    
    var notificationToken: NotificationToken?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.rowHeight = 70.0
        
        totalLabel.text = "Общо: 0.0 лв/месец"
    
        items = realm.objects(TableViewPopulation.self)
        
    
        realTimeUpdate()
        
    }
    

    
    func realTimeUpdate() {
        notificationToken = items?.observe { [weak self] changes in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
            
                tableView.reloadData()
            case .update(_, _, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
        
            case .error(let error):
                fatalError("Error HERE - \(error)")
            }
        }
    }
    
    
    
    // UITableViewDataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomViewCell
        cell.cellTitle.text = items?[indexPath.row].aplienceTitle
        cell.cellPrice.text = items?[indexPath.row].price
        cell.delegate = self
        
        calculateMonthSum()
   
        return cell
        
        
    }
        
    func calculateMonthSum() {
        var sum: Double = 0
        
        if let unwrappedItems = items {
            for object in unwrappedItems {
                
                let convertedStringPrice = Double(object.price) ?? 0.0
                sum += convertedStringPrice
            }
        }
        if sum == 0 {
            totalLabel.text = "Общо: 0.0 лв/месец"
            totalLabel.textColor = .white
            
        } else {
        
            if sum <= 150 {
                totalLabel.textColor = .systemGreen
            } else if sum <= 200 {
                totalLabel.textColor = .systemYellow
            } else {
                totalLabel.textColor = .systemRed
            }
            var convertedSum = String(format: "%.2f", sum)
            totalLabel.text = "Общо: \(convertedSum) лв/месец"
        }
        
    }
    @IBAction func calculate(_ sender: Any) {
        calculateMonthSum()

    }
    
    @IBAction func trashTapped(_ sender: Any) {
        totalLabel.textColor = .white
        totalLabel.text = "Общо: 0.0 лв/месец"
        
        if let _ = self.items {
            
            do {
                try self.realm.write {
                    self.realm.deleteAll()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
           
                print("Error deleating all objects \(error)")
            }
        }
    }
    
}
extension TableViewController: SwipeTableViewCellDelegate {
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
           
            if let deleteCell = self.items?[indexPath.row] {

                    do {
                        try self.realm.write {
                            self.realm.delete(deleteCell)
                            self.calculateMonthSum()
                        }
                    } catch {
                        print("Error deleating a cell \(error)")
                    }
        
            }
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
      
        return options
    }
}
