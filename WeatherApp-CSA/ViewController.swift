//
//  ViewController.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 15.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.delegate = self
        }
    }

    let weatherService = WeatherService()
    var weathers = [Weather]()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherService.loadWeatherData(city: "Moscow") { [weak self] weathers in
            self?.loadData()
            self?.collectionView?.reloadData()
        }
    }
    
    func loadData() {
        
        do {
            let realm = try Realm()
            let weathers = realm.objects(Weather.self).filter("city == %@", "Moscow")
            self.weathers = Array(weathers)
        } catch {
            print(error)
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        cell.configure(whithWeather: self.weathers[indexPath.row])
        
        return cell
    }
}


