//
//  FilterViewModel.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 05/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit

class FilterViewModel: ViewModel {
	var states: [String] = []
	
	init(states: [String]) {
		self.states = states
	}
	
	fileprivate func shouldSelectCell(_ indexPath: IndexPath) {
		let state = self.states[indexPath.row]
				
		NotificationCenter.default.post(name: .filterTapped, object: nil, userInfo: ["state": state])
	}
}

extension FilterViewModel: SectionedCollectionSource, SizeCollectionSource, SelectedCollectionSource {
	func numberOfCollectionCellAtSection(section: Int) -> Int {
		return self.states.count
	}
	
	func collectionCellIdentifierAtIndexPath(indexPath: IndexPath) -> String {
		return FilterCell.identifier()
	}
	
	func collectionCellModelAtIndexPath(indexPath: IndexPath) -> ViewModel {
		return FilterCellModel(state: self.states[indexPath.row])
	}
	
	func cellClassAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell.Type {
		return FilterCell.self
	}
	
	func cellSizeAtIndexPath(indexPath: IndexPath, withCell cell: UICollectionViewCell) -> CGSize {
		return cell.viewSize()
	}
	
	func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: IndexPath, withCell cell: UICollectionViewCell) {
		self.shouldSelectCell(indexPath)
	}
}
