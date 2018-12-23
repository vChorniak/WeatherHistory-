//
//  ViewController.swift
//  WeatherHistory
//
//  Created by user on 12/18/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let dataManager = DataManager()

    var allData = [Station]()
    var filteredData = [Station]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allData = Constant.stations
        initSearch()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    private func initSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Station Name"
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stationDataVC = segue.destination as! StationDataViewController
        if let indexPathRow = tableView.indexPathForSelectedRow?.row {
            if isFiltering() {
                stationDataVC.station = filteredData[indexPathRow]
                stationDataVC.stationName = filteredData[indexPathRow].name
            } else {
                stationDataVC.station = allData[indexPathRow]
                stationDataVC.stationName = allData[indexPathRow].name
            }
        }
    }
    
    func filterdContentForSearcText(_ searchText: String) {
        filteredData = allData.filter({ (station) -> Bool in
            return station.name.lowercased().contains(searchText.lowercased())
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
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredData.count : allData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath)
        if isFiltering() {
            cell.textLabel?.text = filteredData[indexPath.row].name
        } else {
            cell.textLabel?.text = allData[indexPath.row].name
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searhText = searchController.searchBar.text else { return }
        filterdContentForSearcText(searhText)
    }
}
