//
//  HeroDetailCell.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 04/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit
import ReactiveSwift

class HeroDetailCellModel: ViewModel {
	let hero: MutableProperty<Hero?> = MutableProperty(nil)

	init(hero: Hero?) {
		self.hero.value = hero
	}
}

class HeroDetailCell: UICollectionViewCell, ViewBinding {
	typealias VM = HeroDetailCellModel
	var viewModel: VM?

	@IBOutlet weak var heroImageView: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override func viewSize() -> CGSize {
		return CGSize(width: 150, height: 100)
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
		
		self.heroImageView.kf.indicatorType = .activity
		
		if let imageUrl = hero.img, let url = URL(string: imageBaseUrl + imageUrl) {
			self.heroImageView.kf.setImage(with: url, placeholder: placeholder)
		} else {
			self.heroImageView.image = placeholder
		}
	}

}
