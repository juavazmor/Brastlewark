//
//  SelectableFiltersTableViewController.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 20/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

import UIKit

protocol SelectableFiltersDelegate {
	
	func userSelectedFilters(filters: [String])
}

class SelectableFiltersTableViewController: UITableViewController {

	var dataToShow: [String]?
	var selectedData: [String]?
	var delegate: SelectableFiltersDelegate?

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let delegate = self.delegate, let selectedData = selectedData {
			
			delegate.userSelectedFilters(filters: selectedData)
		}
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToShow?.count ?? 0
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)

		guard let dataToShow = self.dataToShow, let selectedData = self.selectedData else { return cell }
		
		cell.textLabel?.text = dataToShow[indexPath.row]
		cell.accessoryType = selectedData.contains(dataToShow[indexPath.row]) ? .checkmark : .none

		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// Keep track of selected data accordingly
		guard
			let cell = tableView.cellForRow(at: indexPath),
			let data = cell.textLabel?.text	else {
				return
		}
		
		if selectedData!.contains(data) {
			
			markDataSelected(data, at: indexPath.row)
			cell.accessoryType = .none
		} else {
			
			selectedData!.remove(at: indexPath.row)
			selectedData!.insert(data, at: indexPath.row)
			cell.accessoryType = .checkmark
		}
	
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func markDataSelected(_ data: String, at index: Int) {
		
		selectedData!.remove(at: selectedData!.index(of: data)!)
		selectedData!.insert("", at: index)
	}
	
	
}
