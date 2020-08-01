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

class HeroMainCellModel: ViewModel {
	let hero: Hero?
	
	init(hero: Hero?) {
		self.hero = hero
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
	
	func configureView() {
		let placeholder = UIImage(named: "pic-default-profilepict")
		
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		
		self.heroTitleLabel.text = self.viewModel?.hero?.localizedName
		self.heroImageView.kf.indicatorType = .activity
		
		if let imageUrl = self.viewModel?.hero?.icon, let url = URL(string: imageBaseUrl + imageUrl) {
			self.heroImageView.kf.setImage(with: url, placeholder: placeholder)
		} else {
			self.heroImageView.image = placeholder
		}
	}
}

