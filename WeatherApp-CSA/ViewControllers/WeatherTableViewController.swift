//
//  WeatherTableViewController.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 08.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import FirebaseFirestore


class WeatherTableViewController: UITableViewController {
    
    
    private let weatherService = WeatherService()
    var cityName = ""
    
    private let db = Firestore.firestore()
    private var forecast = [String : Any]()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cityName
        self.view.backgroundColor = .clear
        
        self.weatherService.loadWeatherData(city: cityName)
        self.readWeathersFromFirestore(city: cityName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        var backgroundImage = UIImageView()
        if let weatherIcon = self.forecast["weatherIcon"] {
            backgroundImage = UIImageView(image: UIImage(named: "\(weatherIcon)"))
        }
        
        self.tableView.backgroundView = backgroundImage
        self.tableView.reloadData()
    }
    
    
    // MARK: - Data
    
    private func readWeathersFromFirestore(city: String) {
        

        db.collection("forecasts").document(self.cityName).addSnapshotListener(includeMetadataChanges: true) {
            documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }

            guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
            self.forecast = data
        }
    }

    
    // MARK: - setBackground
    
    private func setBackground() -> UIImageView {
        
        var backgroundImage = UIImageView()
        
        if let weatherIcon = self.forecast["weatherIcon"] {
            backgroundImage = UIImageView(image: UIImage(named: "\(weatherIcon)"))
        }
        self.tableView.backgroundView = backgroundImage
        return backgroundImage
    }
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
            
            cell.setDate(forecast: self.forecast)
            cell.backgroundColor = .clear
            
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
            
            cell.setWeather(forecast: self.forecast)
            cell.backgroundColor = .clear

            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PressureTableViewCell", for: indexPath) as! PressureTableViewCell
            
            cell.setPressure(forecast: self.forecast)
            cell.backgroundColor = .clear

            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HumidityTableViewCell", for: indexPath) as! HumidityTableViewCell
            
            cell.setHumidity(forecast: self.forecast)
            cell.backgroundColor = .clear

            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CloudinessTableViewCell", for: indexPath) as! CloudinessTableViewCell
            
            cell.setCloudness(forecast: self.forecast)
            cell.backgroundColor = .clear

            return cell
        }
        
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WindTableViewCell", for: indexPath) as! WindTableViewCell
            
            cell.setWind(forecast: self.forecast)
            cell.backgroundColor = .clear

            return cell
        }
        
        return UITableViewCell()
    }
    
    
    // MARK: - Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
        headerView.backgroundColor = .clear
        
        let temperatureLabel = UILabel()
        var temperatureLabelText = String()
        if let temp = self.forecast["temp"] { temperatureLabelText = "\(temp)°"}
            temperatureLabel.frame = CGRect(x: 10,
                                            y: 100,
                                            width: headerView.frame.size.width - 20,
                                            height: headerView.frame.size.height / 5)
            temperatureLabel.textAlignment = .center
            temperatureLabel.text = temperatureLabelText
            temperatureLabel.font = UIFont(name: "Helvetica-Bold", size: 72)
            temperatureLabel.textColor = .white
            temperatureLabel.shadowColor = .black
        headerView.addSubview(temperatureLabel)
        
        
        let cityLabel = UILabel()
        var cityLabelText = String()
        if let city = self.forecast["city"] { cityLabelText = "in \(city)" }
            cityLabel.frame = CGRect(x: 10,
                                     y: 20 + temperatureLabel.frame.size.height,
                                     width: view.frame.size.width - 20,
                                     height: headerView.frame.size.height / 2)
            cityLabel.textAlignment = .center
            cityLabel.text = cityLabelText
            cityLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
            cityLabel.textColor = .white
        headerView.addSubview(cityLabel)
        
        
        let descriptionLabel = UILabel()
        var descriptionLabelText = String()
        if let description = self.forecast["weatherDescription"] {
            descriptionLabelText = "\(description)"
        } else {
            descriptionLabelText = "Please check the spelling of the city"
        }
            descriptionLabel.frame = CGRect(x: 10,
                                            y: cityLabel.frame.size.height - 60,
                                            width: view.frame.size.width - 40,
                                            height: headerView.frame.size.height / 2)
            descriptionLabel.textAlignment = .center
            descriptionLabel.text = descriptionLabelText
            descriptionLabel.font = UIFont(name: "Helvetica", size: 15)
            descriptionLabel.textColor = .white
        headerView.addSubview(descriptionLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.size.width
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
