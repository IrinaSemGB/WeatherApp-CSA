//
//  MyCityTableViewController.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 04.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import RealmSwift

class MyCityTableViewController: UITableViewController {

    
    var cities: Results<City>?
    var token: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To add a new city ⇨"
        self.setBackGroundImage()

        self.pairTableAndRealm()
    }
    
    func setBackGroundImage() {
        
        let backgroundImage = UIImageView(image: UIImage(named: "bg3"))
        self.tableView.backgroundView = backgroundImage
        backgroundImage.contentMode = .scaleAspectFill
    }


    func pairTableAndRealm() {
        
        guard let realm = try? Realm() else { return }
        self.cities = realm.objects(City.self)
        self.token = cities?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                print("fatalError \(error)")
            }
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        showAddCityForm()
    }
    
    
    
    
    func showAddCityForm() {
        
        let alertController = UIAlertController(title: "Введите название города (англ.)", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
        })
        
        let conformAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
            guard let name = alertController.textFields?[0].text else { return }
            self?.addCity(name: name)
        }
        alertController.addAction(conformAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addCity(name: String) {
        let newCity = City()
        newCity.name = name
        
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(newCity, update: .all)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCityTableViewCell", for: indexPath) as! MyCityTableViewCell

        let city = self.cities?[indexPath.row]
        cell.setWeatherInMyCity(city: city!)
        cell.backgroundColor = .clear

        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let city = self.cities?[indexPath.row]
        
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(city!.weathers)
                realm.delete(city!)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherDetail", let cell = sender as? UITableViewCell {
            
            let destination = segue.destination as! WeatherTableViewController
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                destination.cityName = cities?[indexPath.row].name as! String
            }
        }
    }
}
