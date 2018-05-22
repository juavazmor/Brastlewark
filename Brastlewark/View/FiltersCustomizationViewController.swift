//
//  FiltersCustomizationViewController.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 20/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

import UIKit
import SwiftRangeSlider

class FiltersCustomizationViewController: UITableViewController {

	var filters: Filters?
	
	@IBOutlet weak var ageRangeSlider: RangeSlider!
	@IBOutlet weak var heightRangeSlider: RangeSlider!
	@IBOutlet weak var weightRangeSlider: RangeSlider!
	
	private var selectableFiltersData: String? // Keep track of selectableFilters (Professions or Hair color)
	private var selectedProfessions = [String](repeating: "", count: Gnome.availableProfessions.count)
	private var selectedHairColors = [String](repeating: "", count: Gnome.availableHairColors.count)
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		
		if indexPath.section == 0 || indexPath.section == 1 {
			return indexPath
		}
		
		return nil
	}
	
	// MARK: - Segues
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		guard let identifier = segue.identifier else { return }
		
		switch identifier {
			
		case "SaveFilters":
			filters = Filters(professions: self.selectedProfessions.filter{ !$0.isEmpty },
							  hairColors: self.selectedHairColors.filter{ !$0.isEmpty },
							  ageRange: (Int(ageRangeSlider.lowerValue), Int(ageRangeSlider.upperValue)),
							  weightRange: (weightRangeSlider.lowerValue, weightRangeSlider.upperValue),
							  heightRange: (heightRangeSlider.lowerValue, heightRangeSlider.upperValue))
			
		case "ShowProfessions":
			guard let selectableVC = segue.destination as? SelectableFiltersTableViewController else { return }
			selectableVC.dataToShow = Array(Gnome.availableProfessions)
			selectableVC.selectedData = self.selectedProfessions
			selectableVC.delegate = self
			self.selectableFiltersData = identifier
			
		case "ShowHairColors":
			guard let selectableVC = segue.destination as? SelectableFiltersTableViewController else { return }
			selectableVC.dataToShow = Array(Gnome.availableHairColors)
			selectableVC.selectedData = self.selectedHairColors
			selectableVC.delegate = self
			self.selectableFiltersData = identifier
			
		default:
			print("")
		}
	}
}

extension FiltersCustomizationViewController: SelectableFiltersDelegate {
	
	func userSelectedFilters(filters: [String]) {
		
		guard let filterSelected = self.selectableFiltersData else { return }
		
		switch filterSelected {
		case "ShowProfessions":
			self.selectedProfessions = filters
			tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text = filters.filter{ !$0.isEmpty }.joined(separator: ", ")
			
		case "ShowHairColors":
			self.selectedHairColors = filters
			tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text = filters.filter{ !$0.isEmpty }.joined(separator: ", ")
		default:
			return
		}
	}
}
