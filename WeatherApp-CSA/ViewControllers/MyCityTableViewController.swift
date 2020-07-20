//
//  MyCityTableViewController.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 04.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore


class MyCityTableViewController: UITableViewController {
    
    
    var cities = [FirebaseCity]()
    private let reference = Database.database().reference(withPath: "cities")
    private let db = Firestore.firestore()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackGroundImage()
        
        self.reference.observe(.value) { snapshot in
            var cities: [FirebaseCity] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let city = FirebaseCity(snapshot: snapshot) {
                    cities.append(city)
                }
            }
            self.cities = cities
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - setBackGroundImage
    
    private func setBackGroundImage() {
        
        let backgroundImage = UIImageView(image: UIImage(named: "bg3"))
        self.tableView.backgroundView = backgroundImage
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "To add new city", message: "Please enter a city name (in English 🇬🇧)", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                let cityName = textField.text else { return }
            
            let city = FirebaseCity(name: cityName, zipcode: Int.random(in: 100000...999999))
            let cityReference = self.reference.child(cityName.lowercased())
            cityReference.setValue(city.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCityTableViewCell", for: indexPath) as? MyCityTableViewCell else { return UITableViewCell() }

        let city = self.cities[indexPath.row]
        cell.myCityNameLabel?.text = city.name
        cell.backgroundColor = .clear

        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let city = cities[indexPath.row]
            city.reference?.removeValue()
            
            db.collection("forecasts").document(city.name).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherDetail", let cell = sender as? UITableViewCell {
            
            let destination = segue.destination as! WeatherTableViewController
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                destination.cityName = self.cities[indexPath.row].name
            }
        }
    }
}
