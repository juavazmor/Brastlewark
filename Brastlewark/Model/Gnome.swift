//
//  Gnome.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 17/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

import UIKit

struct Gnome {
	
	let uid: Int
	let name: String
	let thumbnailURL: String
	let age: Int
	let weight: Double
	let height: Double
	let hairColor: String
	let professions: [String]
	let friends: [String]
	
}

extension Gnome {
	
	private static let jsonGnomeId = "id"
	private static let jsonGnomeName = "name"
	private static let jsonGnomeThumbURL = "thumbnail"
	private static let jsonGnomeAge = "age"
	private static let jsonGnomeWeight = "weight"
	private static let jsonGnomeHeight = "height"
	private static let jsonGnomeHair = "hair_color"
	private static let jsonGnomeProfs = "professions"
	private static let jsonGnomeFriends = "friends"
	
	init?(dict: [String: Any]) {
		
		guard
			let uid 			= dict[Gnome.jsonGnomeId] as? Int,
			let name 			= dict[Gnome.jsonGnomeName] as? String,
			let thumbnailURL 	= dict[Gnome.jsonGnomeThumbURL] as? String,
			let age 			= dict[Gnome.jsonGnomeAge] as? Int,
			let weight 			= dict[Gnome.jsonGnomeWeight] as? Double,
			let height 			= dict[Gnome.jsonGnomeHeight] as? Double,
			let hairColor 		= dict[Gnome.jsonGnomeHair] as? String,
			let professions 	= dict[Gnome.jsonGnomeProfs] as? [String],
			let friends 		= dict[Gnome.jsonGnomeFriends] as? [String]
		
			else {
				return nil
		}
		
		self.uid 			= uid
		self.name 			= name
		self.thumbnailURL 	= thumbnailURL
		self.age 			= age
		self.weight 		= weight
		self.height 		= height
		self.hairColor 		= hairColor
		self.professions = professions
		self.friends 		= friends

		// Keep track of possible hair colors
		Gnome.availableHairColors.insert(hairColor)

		// Keep track of possible professions
		Gnome.availableProfessions = Gnome.availableProfessions.union(Set(professions))
	}
}

extension Gnome {
	
	public static var availableProfessions = Set<String>()
	public static var availableHairColors = Set<String>()
}
