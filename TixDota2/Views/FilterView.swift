//
//  FilterView.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 31/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

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

class FilterView: UIView, ViewBinding {
	typealias VM = FilterViewModel
	var viewModel: VM?
	
	lazy var collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	lazy var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: self.collectionViewLayout)
	private var collectionViewBinding: CollectionViewBindingUtil<FilterViewModel>?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func viewSize() -> CGSize {
		let width = UIScreen.main.bounds.width
		
		return CGSize(width: width, height: 60)
	}
	
	func bindViewModel(viewModel: VM?) {
		self.viewModel = viewModel
		self.backgroundColor = UIColor.primaryColor
		
		collectionViewBinding = CollectionViewBindingUtil(source: self.viewModel ?? FilterViewModel(states: []))
		collectionViewBinding?.bindFlowDelegateWithCollectionView(collectionView: collectionView)
		collectionViewBinding?.bindDatasourceWithCollectionView(collectionView: collectionView)
		
		configureCollectionView()
	}
	
	fileprivate func configureCollectionView() {
		self.addSubview(self.collectionView)
		
		self.setFilterViewConstraints()
				
		self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		self.collectionViewLayout.scrollDirection = .horizontal
		self.collectionView.backgroundColor = UIColor.clear
		self.collectionView.isScrollEnabled = true
		self.collectionView.register(FilterCell.nib(), forCellWithReuseIdentifier: FilterCell.identifier())
	}
	
	fileprivate func setFilterViewConstraints() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint(item: collectionView,
						   attribute: NSLayoutConstraint.Attribute.top,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: self,
						   attribute: NSLayoutConstraint.Attribute.top,
						   multiplier: 1,
						   constant: 10).isActive = true
		
		NSLayoutConstraint(item: collectionView,
						   attribute: NSLayoutConstraint.Attribute.left,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: self,
						   attribute: NSLayoutConstraint.Attribute.left,
						   multiplier: 1,
						   constant: -10).isActive = true
		
		NSLayoutConstraint(item: collectionView,
						   attribute: NSLayoutConstraint.Attribute.right,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: self,
						   attribute: NSLayoutConstraint.Attribute.right,
						   multiplier: 1,
						   constant: 0).isActive = true
		
		NSLayoutConstraint(item: collectionView,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: self,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   multiplier: 1,
						   constant: 0).isActive = true
	}
}
