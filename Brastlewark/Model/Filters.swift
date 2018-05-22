//
//  Filters.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 20/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

struct Filters {
	
	let professions: [String]?
	let hairColors: [String]?
	let ageRange: (Int, Int)?
	let weightRange: (Double, Double)?
	let heightRange: (Double, Double)?
}

extension Filters {

	func filterGnomes(gnomes: [Gnome]) -> [Gnome] {
		
		return gnomes.filter { (gnome) -> Bool in
			
			var isValid = true
			
			// Professions
			if let incomingProfessions = professions, incomingProfessions.count > 0 {
				
				var hasProfession = false
				
				for profession in incomingProfessions {
					
					if gnome.professions.contains(profession) {
						hasProfession = true
					}
				}
				
				isValid = isValid && hasProfession
			}
			
			// Hair color
			if let incomingHairColors = hairColors, incomingHairColors.count > 0 {
				
				var hasPinkColor = false
				
				for incomingHairColor in incomingHairColors {
					
					if gnome.hairColor == incomingHairColor {
						hasPinkColor = true
					}
				}
				
				isValid = isValid && hasPinkColor
			}
			
			// Age
			if let incomingAgeRange = ageRange {
				
				isValid = isValid && (gnome.age >= incomingAgeRange.0 && gnome.age <= incomingAgeRange.1)
			}
			
			// Weight
			if let incomingWeightRange = weightRange {
				
				isValid = isValid && (gnome.weight >= incomingWeightRange.0 && gnome.weight <= incomingWeightRange.1)
			}
			
			// Height
			if let incomingHEightRange = heightRange {
				
				isValid = isValid && (gnome.height >= incomingHEightRange.0 && gnome.height <= incomingHEightRange.1)
			}
			
			return isValid
		}
	}
}
