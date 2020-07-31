//
//  FilterCell.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 31/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit


class FilterCellModel: ViewModel {
	init() {
	}
}

class FilterCell: UICollectionViewCell, ViewBinding {
	@IBOutlet weak var filterTitleLabel: UILabel!
	@IBOutlet weak var containerView: UIView!
	
	typealias VM = FilterCellModel
	var viewModel: VM?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
    }
	
	func bindViewModel(viewModel: VM?) {
		self.containerView.backgroundColor = UIColor.secondaryColor
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		
		self.filterTitleLabel.textColor = .white
		self.filterTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
		self.filterTitleLabel.text = "Tiket.com"
	}
}
