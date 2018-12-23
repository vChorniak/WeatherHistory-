//
//  StationDataViewController.swift
//  WeatherHistory
//
//  Created by user on 12/18/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

class StationDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let userInitiated = DispatchQueue.global(qos: .userInitiated)
    
    let searchController = UISearchController(searchResultsController: nil)
    let dataManager = DataManager()
    
    var stationIndex = 0
    var stationData = [StationData]()
    var filteredData = [StationData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchController()
        navigationItem.title = Constant.stations[stationIndex].name

        if Constant.stations[stationIndex].data.isEmpty {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            userInitiated.async {
                self.loadData()
            }
        } else {
             stationData = Constant.stations[stationIndex].data
        }
    }
    
    func loadData() {
        dataManager.readData(forStation: Constant.stations[stationIndex].internalTitle, complition: { (station) in
            DispatchQueue.main.async {
                self.stationData = station
                Constant.stations[self.stationIndex].data = station
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }) { (error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.showAlert(withMesage: error.localizedDescription)
            }
        }
    }
    
    func initSearchController() {
        filteredData = Constant.stations[stationIndex].data
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Year"
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DataDetailViewController
        if let indexPatch = tableView.indexPathForSelectedRow?.row {
            detailVC.stationName = Constant.stations[stationIndex].name
            if isFiltering() {
                detailVC.dataArray = filteredData[indexPatch]
            } else {
                detailVC.dataArray = stationData[indexPatch]
            }
        }
    }
    
    func filterdContentForSearcText(_ searchText: String) {
        filteredData = stationData.filter({ (station) -> Bool in
            return station.year.contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func showAlert(withMesage message: String) {
        let alert = UIAlertController(title: "Error loading data", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    deinit {
        self.searchController.view.removeFromSuperview()
    }
}

extension StationDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredData.count : stationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        if isFiltering() {
            let station = filteredData[indexPath.row]
            cell.textLabel?.text = DateFormat.dateFormatter(time: station.month) + " " + station.year
        } else {
            let station = stationData[indexPath.row]
            cell.textLabel?.text = DateFormat.dateFormatter(time: station.month) + " " + station.year
        }
        return cell
    }  
}

extension StationDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StationDataViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterdContentForSearcText(searchController.searchBar.text!)
    }
}
