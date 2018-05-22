//
//  GnomesDataSource.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 17/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

import UIKit
import Alamofire

class GnomesDataProvider: NSObject {
	
	let repository: GnomeRepository
	var gnomes: [Gnome]?
	
	// MARK: - init
	
	init(repository: GnomeRepository) {
		self.repository = repository
	}
	
	convenience override init() {
		self.init(repository: GnomeAPIRepository())
	}
	
	// MARK: - Public
	
	public func gnomes(completionHandler: @escaping ([Gnome]) -> Void) {
		
		if let gnomes = gnomes {
			completionHandler(gnomes)
		} else {
			repository.retrieveAllGnomes { gnomes in
				self.gnomes = gnomes
				completionHandler(gnomes)
			}
		}
	}
}
