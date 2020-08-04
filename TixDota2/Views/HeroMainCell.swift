//
//  HeroMainCell.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 30/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import ReactiveSwift

class HeroMainCellModel: ViewModel {
	let hero: MutableProperty<Hero?> = MutableProperty(nil)

	init(hero: Hero?) {
		self.hero.value = hero
	}
}

class HeroMainCell: UICollectionViewCell, ViewBinding {

	@IBOutlet weak var heroImageView: UIImageView!
	@IBOutlet weak var heroTitleLabel: UILabel!
	
	typealias VM = HeroMainCellModel
	var viewModel: VM?
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override func viewSize() -> CGSize {
		return CGSize(width: 100, height: 100)
	}
	
	func bindViewModel(viewModel: VM?) {
		self.viewModel = viewModel
		
		self.configureView()
	}
	
	private func configureView() {
		let placeholder = UIImage(named: "pic-default-profilepict")
		
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		
		guard let hero = self.viewModel?.hero.value else { return }
		
		self.heroTitleLabel.text = hero.localizedName
		self.heroImageView.kf.indicatorType = .activity
		
		if let imageUrl = hero.icon, let url = URL(string: imageBaseUrl + imageUrl) {
			self.heroImageView.kf.setImage(with: url, placeholder: placeholder)
		} else {
			self.heroImageView.image = placeholder
		}
	}
}

