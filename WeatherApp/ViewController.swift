//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nathan Sharma on 27/02/2019.
//  Copyright © 2019 Nathan Sharma. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var dataItems: [WeatherRemoteDTO] = []

    var weatherFetcher: BasicWeatherFetcher!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: show spinner
        spinner.startAnimating()
        
        let london = WeatherAPIEndpoint.forcast(CLLocationCoordinate2D(latitude: 51.5003646652, longitude: -0.1214328476))
        weatherFetcher = BasicWeatherFetcher(URLSession(configuration: .default))
        
        weatherFetcher.get(london) { [unowned self]
            (result) in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result {
                case .success(let dataList):
                    self.dataItems = dataList.info
                    self.tableView.reloadData()
                case .failure(_):
                    break
                }
            }
        }
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.reuseIdentifier, for: indexPath) as? InfoTableViewCell else {
            fatalError("unexpected cell class")
        }
        configureCell(cell, at: indexPath)
        return cell
    }


    func configureCell(_ cell: InfoTableViewCell, at indexPath: IndexPath) {


        let infoDic = dataItems[indexPath.row]
        cell.descriptionLabel.text =  infoDic.weather.description
        cell.dateLabel.text = infoDic.dt_txt
        cell.maxTempLabel.text = String(infoDic.main.temp_max)
        cell.minTempLabel.text = String(infoDic.main.temp_max)
        cell.speedLabel.text = String(infoDic.wind.speed)
    }


}


