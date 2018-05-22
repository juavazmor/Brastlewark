//
//  GnomeRepository.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 22/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

import Foundation
import Alamofire

protocol GnomeRepository {
	func retrieveAllGnomes(completionHandler: @escaping ([Gnome]) -> Void) -> Void
}

class GnomeAPIRepository: GnomeRepository {
	
	func retrieveAllGnomes(completionHandler: @escaping ([Gnome]) -> Void) -> Void {
		
		Alamofire.request(AppConfig.jsonURL).responseJSON { response in
			
			guard let json = response.result.value as? [String: Any] else { return }
			
			guard let gnomesArray = json["Brastlewark"] as? [Any] else { return }
		
			var gnomes: [Gnome] = []
			
			for gnome in gnomesArray {
				
				guard let gnomeInfo = gnome as? [String: Any] else { return }
				if let newGnome = Gnome(dict: gnomeInfo) {
					gnomes.append(newGnome)
				}
			}
			
			completionHandler(gnomes)
		}
	}
}
