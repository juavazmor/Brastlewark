//
//  GnomeProfileViewController.swift
//  Brastlewark
//
//  Created by Juan Diego Vazquez Moreno on 17/05/2018.
//  Copyright © 2018 Juan Diego Vazquez Moreno. All rights reserved.
//

import UIKit
import SDWebImage

class GnomeProfileViewController: UIViewController {

	var gnome: Gnome?
	
	@IBOutlet weak var gnomeNameLabel: UILabel!
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var hairColorLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var weightLabel: UILabel!
	@IBOutlet weak var professionsLabel: UILabel!
	@IBOutlet weak var friendsLabel: UILabel!
	
	override func viewDidLoad() {

		super.viewDidLoad()
		self.configureView()
    }
	
	func configureView() {
		
		self.navigationController?.navigationBar.prefersLargeTitles = false
		
		guard let gnome = self.gnome else { return }
		
		profileImage.sd_setImage(with: URL(string: gnome.thumbnailURL), completed: nil)
		gnomeNameLabel.text = gnome.name
		ageLabel.text = "Age: \(gnome.age)"
		hairColorLabel.text = "Hair Color: \(gnome.hairColor)"
		heightLabel.text = "Height: \(gnome.height)"
		weightLabel.text = "Weight: \(gnome.weight)"
		professionsLabel.text = gnome.professions.joined(separator: ", ")
		friendsLabel.text = gnome.friends.joined(separator: ", ")
	}

}
