//
//  HeroMainCell.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 30/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit

import Foundation
import UIKit

class HeroMainCellModel: ViewModel {
//	let hero: Hero?
	
//	init(hero: Hero?) {
//		self.hero = hero
//	}
	init() {}
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
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		self.heroTitleLabel.text = "halo"
		self.heroImageView.image = UIImage(named: "ico-love-selected")
		
	}
}

