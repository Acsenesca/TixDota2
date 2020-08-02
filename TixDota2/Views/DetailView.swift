//
//  DetailView.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 31/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit
import ReactiveSwift

class DetailViewModel: ViewModel {
	let hero: MutableProperty<Hero?> = MutableProperty(nil)
	
	init(hero: Hero?) {
		self.hero.value = hero
	}
}

class DetailView: UIView, ViewBinding {

	@IBOutlet weak var heroMainImageView: UIImageView!
	@IBOutlet weak var heroTypeImageView: UIImageView!
	@IBOutlet weak var heroNameLabel: UILabel!
	@IBOutlet weak var rolesLabel: UILabel!
	
	@IBOutlet weak var baseAttackLabel: UILabel!
	@IBOutlet weak var baseArmorLabel: UILabel!
	@IBOutlet weak var moveSpeedLabel: UILabel!
	@IBOutlet weak var baseHealthLabel: UILabel!
	@IBOutlet weak var baseManaLabel: UILabel!
	@IBOutlet weak var attributeLabel: UILabel!
	
	typealias VM = DetailViewModel
	var viewModel: VM?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func bindViewModel(viewModel: VM?) {
		self.viewModel = viewModel

		self.configureView()
	}
	
	func configureView() {
		let placeholder = UIImage(named: "pic-default-profilepict")
		self.heroMainImageView.kf.indicatorType = .activity
		
		guard let hero = self.viewModel?.hero.value else { return }
		
		if let imageUrl = hero.img, let url = URL(string: imageBaseUrl + imageUrl) {
			self.heroMainImageView.kf.setImage(with: url, placeholder: placeholder)
		} else {
			self.heroMainImageView.image = placeholder
		}
		
		if let attackType = hero.attackType {
			if  attackType == AttackType.Ranged {
				self.heroTypeImageView.image = UIImage(named: "ico-ranged")
			} else {
				self.heroTypeImageView.image = UIImage(named: "ico-melee")
			}
		} else {
			self.heroTypeImageView.image = placeholder
		}

		if let baseAttackMin = hero.baseAttackMin, let baseAttackMax = hero.baseAttackMax {
			self.baseAttackLabel.text = "\(String(describing: baseAttackMin)) - \(String(describing: baseAttackMax))"
		}
		
		if let baseArmor = hero.baseArmor {
			self.baseArmorLabel.text = "\(String(describing: baseArmor))"
		}
		
		if let moveSpeed = hero.moveSpeed {
			self.moveSpeedLabel.text = "\(String(describing: moveSpeed))"
		}
		
		if let baseHealth = hero.baseHealth {
			self.baseHealthLabel.text = "\(String(describing: baseHealth))"
		}
		
		if let baseMana = hero.baseMana {
			self.baseManaLabel.text = "\(String(describing: baseMana))"
		}
		
		self.attributeLabel.text = hero.primaryAttr
		self.heroNameLabel.text = hero.localizedName
		self.rolesLabel.text = "halohai"
		
	}
}
