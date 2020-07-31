//
//  HeroViewController.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 30/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit

class HeroViewModel: ViewModel {
	init() {
		
	}
}

extension HeroViewModel: SectionedCollectionSource, SizeCollectionSource, SelectedCollectionSource {
	func numberOfCollectionCellAtSection(section: Int) -> Int {
		return 10
	}
	
	func collectionCellIdentifierAtIndexPath(indexPath: IndexPath) -> String {
		return HeroMainCell.identifier()
	}
	
	func collectionCellModelAtIndexPath(indexPath: IndexPath) -> ViewModel {
		return HeroMainCellModel()
	}
	func cellClassAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell.Type {
		return HeroMainCell.self
	}
	
	func cellSizeAtIndexPath(indexPath: IndexPath, withCell cell: UICollectionViewCell) -> CGSize {
		return CGSize(width: 100, height: 100)
	}
	
	func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: IndexPath, withCell cell: UICollectionViewCell) {
//		shouldSelectCell(indexPath)
	}
}


class HeroViewController: UIViewController {
	typealias VM = HeroViewModel
	var viewModel: VM
	
	lazy var collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	lazy var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.collectionViewLayout)
	private var collectionViewBinding: CollectionViewBindingUtil<HeroViewModel>?
	
	lazy var filterView: FilterView = {
		let viewModel = FilterViewModel()
		let view = FilterView.viewFromXib()
		view.bindViewModel(viewModel: viewModel)
		
		return view
	}()
	
	lazy var separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		
		return view
	}()

	init(viewModel: HeroViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear

		self.bindViewModel()
		self.configureView()
//		self.configureSeparatorView()
//		self.configureCollectionView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	fileprivate func bindViewModel() {
		collectionViewBinding = CollectionViewBindingUtil(source: self.viewModel)
		collectionViewBinding?.bindFlowDelegateWithCollectionView(collectionView: collectionView)
		collectionViewBinding?.bindDatasourceWithCollectionView(collectionView: collectionView)
	}
	
	fileprivate func configureCollectionView() {
		view.addSubview(self.collectionView)
		
//		setCollectionViewConstraints()
		
//		self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
		self.collectionView.backgroundColor = UIColor.red
		self.collectionView.showsVerticalScrollIndicator = false
		self.collectionViewLayout.scrollDirection = .vertical
//		self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset
		self.collectionView.register(HeroMainCell.nib(), forCellWithReuseIdentifier: HeroMainCell.identifier())
	}
	
	fileprivate func configureView() {
		view.addSubview(self.filterView)
		
		self.edgesForExtendedLayout = []
		self.setListHeroViewConstraints()
	}
	
	fileprivate func configureSeparatorView() {
		view.addSubview(self.separatorView)
		
//		setSeparatorViewConstraints()
	}
	
//	fileprivate func setSeparatorViewConstraints() {
//		separatorView.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint(item: separatorView,
//						   attribute: NSLayoutConstraint.Attribute.bottom,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: collectionView,
//						   attribute: NSLayoutConstraint.Attribute.top,
//						   multiplier: 1,
//						   constant: -16).isActive = true
//
//		NSLayoutConstraint(item: separatorView,
//						   attribute: NSLayoutConstraint.Attribute.left,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: view,
//						   attribute: NSLayoutConstraint.Attribute.left,
//						   multiplier: 1,
//						   constant: 16).isActive = true
//
//		NSLayoutConstraint(item: separatorView,
//						   attribute: NSLayoutConstraint.Attribute.right,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: view,
//						   attribute: NSLayoutConstraint.Attribute.right,
//						   multiplier: 1,
//						   constant: -16).isActive = true
//
//		NSLayoutConstraint(item: separatorView,
//						   attribute: NSLayoutConstraint.Attribute.height,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: nil,
//						   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
//						   multiplier: 1,
//						   constant: 1).isActive = true
//	}
	
	fileprivate func setListHeroViewConstraints() {
		filterView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint(item: filterView,
						   attribute: NSLayoutConstraint.Attribute.top,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.top,
						   multiplier: 1,
						   constant: 0).isActive = true
		
		NSLayoutConstraint(item: filterView,
						   attribute: NSLayoutConstraint.Attribute.left,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.left,
						   multiplier: 1,
						   constant: 0).isActive = true
		
		NSLayoutConstraint(item: filterView,
						   attribute: NSLayoutConstraint.Attribute.right,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.right,
						   multiplier: 1,
						   constant: 0).isActive = true
		
		NSLayoutConstraint(item: filterView,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.top,
						   multiplier: 1,
						   constant: 50).isActive = true

//		NSLayoutConstraint(item: filterView,
//						   attribute: NSLayoutConstraint.Attribute.height,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: nil,
//						   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
//						   multiplier: 1,
//						   constant: filterView.viewSize().height).isActive = true
	}
	
//	fileprivate func setCollectionViewConstraints() {
//		collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint(item: collectionView,
//						   attribute: NSLayoutConstraint.Attribute.left,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: view,
//						   attribute: NSLayoutConstraint.Attribute.left,
//						   multiplier: 1,
//						   constant: 16).isActive = true
//
//		NSLayoutConstraint(item: collectionView,
//						   attribute: NSLayoutConstraint.Attribute.right,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: view,
//						   attribute: NSLayoutConstraint.Attribute.right,
//						   multiplier: 1,
//						   constant: -16).isActive = true
//
//		NSLayoutConstraint(item: collectionView,
//						   attribute: NSLayoutConstraint.Attribute.bottom,
//						   relatedBy: NSLayoutConstraint.Relation.equal,
//						   toItem: view,
//						   attribute: NSLayoutConstraint.Attribute.bottom,
//						   multiplier: 1,
//						   constant: -16).isActive = true
//	}

}
