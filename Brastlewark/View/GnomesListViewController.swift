//
//  GnomesListViewController.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 17/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

import UIKit
import Alamofire

class GnomesListViewController: UITableViewController {
	
	var gnomesDataProvider: GnomesDataProvider?
	
	var gnomes = [Gnome]()
	var filteredGnomes: [Gnome]?
	
	let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		// Data provider
		gnomesDataProvider = GnomesDataProvider()
		gnomesDataProvider?.gnomes(completionHandler: { gnomesReady in
			
			self.gnomes = gnomesReady
			self.tableView.reloadData()
		})
    }
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (isFiltering()) {
			return filteredGnomes!.count
		}
		
		return gnomes.count
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "gnomeCustomCell", for: indexPath)
		
		cell.textLabel?.text = getGnomeForIndexPath(indexPath).name

        return cell
    }

	// MARK: - Private instance methods
	
	func isFiltering() -> Bool {
		return filteredGnomes != nil //searchController.isActive && !searchBarIsEmpty()
	}
	
	func getGnomeForIndexPath(_ indexPath: IndexPath) -> Gnome {
		
		if (isFiltering()) {
			return filteredGnomes![indexPath.row]
		} else {
			return gnomes[indexPath.row]
		}
	}
	
	// MARK: - Segues
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		guard let identifier = segue.identifier else { return }
		
		switch identifier {
			
		case "showProfile":
			guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
			let vc = segue.destination as! GnomeProfileViewController
			vc.gnome = getGnomeForIndexPath(indexPath)
			
		default:
			print("")
		}
	}
}

// Filter screen extension

extension GnomesListViewController {
	
	@IBAction func cancelFiltersCustomization(_ segue: UIStoryboardSegue) {
		clearFilters()
	}
	
	@IBAction func saveFilters(_ segue: UIStoryboardSegue) {
		
		guard
			let filtersCustomizationVC = segue.source as? FiltersCustomizationViewController,
			let filters = filtersCustomizationVC.filters else {
				return
		}
		
		configureClearFilterButton()
		filteredGnomes = filters.filterGnomes(gnomes: gnomes)
		self.tableView.reloadData()
	}
	
	func configureClearFilterButton() {
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear filters", style: .plain, target: self, action: #selector(clearFilters))
	}
	
	@objc func clearFilters() {
		
		filteredGnomes = nil
		self.tableView.reloadData()
		
		if self.navigationItem.leftBarButtonItem != nil {
			self.navigationItem.leftBarButtonItem = nil
		}
	}
}
