//
//  LocationsListViewController.swift
//  ReportList
//
//  Created by Naresh kumar Nagulavancha on 3/30/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import UIKit
import CoreData

fileprivate let locationCell = "LocationListTableViewCell"

class LocationsListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var locations: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: locationCell, bundle: nil), forCellReuseIdentifier: locationCell)
        fetchLocations()
        // Do any additional setup after loading the view.
    }
    
    func fetchLocations() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            locations = result as? [Locations] ?? []
            self.tableView.reloadData()
            print(result)
            
        } catch {
            
            print("Failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationDetail" {
            guard let vc = segue.destination as? LocationDetailViewController else {return}
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            vc.locations = [locations[indexpath.row]]
        }
    }

}

extension LocationsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCell, for: indexPath) as! LocationListTableViewCell
        cell.ownerLabel.text = locations[indexPath.row].value(forKey: "owner") as? String
        cell.addressLine1Label.text = locations[indexPath.row].value(forKey: "address1") as? String
        cell.categoryLabel.text = locations[indexPath.row].value(forKey: "category") as? String
        cell.dateLabel.text = locations[indexPath.row].value(forKey: "date") as? String
        cell.zipcodeLabel.text = locations[indexPath.row].value(forKey: "physicalZip") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
}

extension LocationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "locationDetail", sender: nil)
    }
}
