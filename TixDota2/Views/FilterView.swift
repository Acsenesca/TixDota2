//
//  FilterView.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 31/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit

class FilterViewModel: ViewModel {

	init() {
	}
}

extension FilterViewModel: SectionedCollectionSource, SizeCollectionSource {
	func numberOfCollectionCellAtSection(section: Int) -> Int {
		return 10
	}
	func collectionCellIdentifierAtIndexPath(indexPath: IndexPath) -> String {
		return FilterCell.identifier()
	}
	func collectionCellModelAtIndexPath(indexPath: IndexPath) -> ViewModel {
		return FilterCellModel()
	}
	func cellClassAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell.Type {
		return FilterCell.self
	}
	func cellSizeAtIndexPath(indexPath: IndexPath, withCell cell: UICollectionViewCell) -> CGSize {
		return CGSize(width: 100, height: 40)
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
	
	func bindViewModel(viewModel: VM?) {
		self.viewModel = viewModel
		self.backgroundColor = UIColor.primaryColor
		
		collectionViewBinding = CollectionViewBindingUtil(source: self.viewModel ?? FilterViewModel())
		collectionViewBinding?.bindFlowDelegateWithCollectionView(collectionView: collectionView)
		collectionViewBinding?.bindDatasourceWithCollectionView(collectionView: collectionView)
		
		configureCollectionView()
	}
	
	fileprivate func configureCollectionView() {

		self.addSubview(self.collectionView)
				
		self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		self.collectionViewLayout.scrollDirection = .horizontal
		self.collectionView.backgroundColor = UIColor.clear
		self.collectionView.isScrollEnabled = true
		self.collectionView.register(FilterCell.nib(), forCellWithReuseIdentifier: FilterCell.identifier())
	}
}
