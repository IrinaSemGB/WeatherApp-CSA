//
//  WeatherTableViewController.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 08.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import RealmSwift


class WeatherTableViewController: UITableViewController {
    
    
    let weatherService = WeatherService()
    var weathers = List<Weather>()
    
//    let dateFormatter = DateFormatter()
    var cityName = ""
    var token: NotificationToken?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cityName
        self.view.backgroundColor = .clear
        
//        self.weatherService.loadWeatherData(city: cityName)
        self.pairTableAndRealm()
        
        print(weathers)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        self.weatherService.loadWeatherData(city: cityName)
        print(cityName)
    }
    
    
    func pairTableAndRealm() {
        guard let realm = try? Realm(), let city = realm.object(ofType: City.self, forPrimaryKey: cityName) else { return }
        
        self.weathers = city.weathers
        
        token = weathers.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                    tableView.tableHeaderView = self?.createTableHeader()
                    tableView.backgroundView = self?.setBackground()
                
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    tableView.endUpdates()
                case .error(let error):
                    print("fatalError \(error)")
            }
            
            print("changes \(changes)")
        }
    }
    
    func setBackground() -> UIImageView {
        
        let weathers = self.weathers
        let weatherFirst = weathers.first
        
        
        let backgroundImage = UIImageView(image: UIImage(named: "\(weatherFirst?.weatherIcon ?? "01d")"))
        self.tableView.backgroundView = backgroundImage
        
        return backgroundImage
    }
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell

        let weather = self.weathers[indexPath.row]
        cell.setWeather(weather: weather)
        cell.backgroundColor = .clear
        
        print(weather)

        return cell
    }

    
    func createTableHeader() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
        headerView.backgroundColor = .clear
        
        let weatherFirst = self.weathers.first
        
//        let weatherIconImageView = UIImageView()
//
//        weatherIconImageView.frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height)
//        weatherIconImageView.contentMode = .scaleAspectFill
//        weatherIconImageView.image = UIImage(named: "\(weatherFirst?.weatherIcon ?? "01d")")
        
        let temperatureLabel = UILabel()
        
        temperatureLabel.frame = CGRect(x: 10, y: 100, width: headerView.frame.size.width - 20, height: headerView.frame.size.height / 5)
        temperatureLabel.textAlignment = .center
        temperatureLabel.text = "\(weatherFirst?.temp ?? 0)°"
        temperatureLabel.font = UIFont(name: "Helvetica-Bold", size: 72)
        temperatureLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        
        descriptionLabel.frame = CGRect(x: 10, y: 10 + temperatureLabel.frame.size.height, width: view.frame.size.width - 20, height: headerView.frame.size.height / 2)
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "\(weatherFirst?.weatherName ?? "Информация отсутсвует")"
        descriptionLabel.textColor = .white
        
//        headerView.addSubview(weatherIconImageView)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(descriptionLabel)
        
        return headerView
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
