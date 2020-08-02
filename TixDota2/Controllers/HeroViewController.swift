//
//  HeroViewController.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 30/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ReactiveSwift

class HeroViewModel: ViewModel {
	var heroes: MutableProperty<[Hero]?> = MutableProperty(nil)
	var didSelectHandler: ((Hero) -> Void) = {_ in }
	
	init() { }
	
	func requestListHeroes(completionHandler: @escaping () -> Void) {
		AF.request(listHeroAPIUrl).responseJSON{ response in
			switch (response.result) {
			case .success:
				if let data = response.data {
					do {
						let decoder = JSONDecoder()
						decoder.keyDecodingStrategy = .convertFromSnakeCase
						let jsonData = try decoder.decode([Hero].self, from: data)
						
						self.heroes.value = jsonData
						
						completionHandler()
					} catch {
						print(error.localizedDescription)
					}
				}
			case .failure( let error):
				
//					if let err = error as? URLError, err.code == .notConnectedToInternet {
//					   // no internet connection
				print("AAA", error.responseCode)
//				   } else {
//					   // other failures
//				   }
			}
		}
	}
	
	fileprivate func shouldSelectCell(_ indexPath: IndexPath) {
		guard let hero = self.heroes.value?[indexPath.row] else { return }
		self.didSelectHandler(hero)
	}
}

extension HeroViewModel: SectionedCollectionSource, SizeCollectionSource, SelectedCollectionSource {
	func numberOfCollectionCellAtSection(section: Int) -> Int {
		return self.heroes.value?.count ?? 0
	}
	
	func collectionCellIdentifierAtIndexPath(indexPath: IndexPath) -> String {
		return HeroMainCell.identifier()
	}
	
	func collectionCellModelAtIndexPath(indexPath: IndexPath) -> ViewModel {
		return HeroMainCellModel(hero: self.heroes.value?[indexPath.row])
	}
	func cellClassAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell.Type {
		return HeroMainCell.self
	}
	
	func cellSizeAtIndexPath(indexPath: IndexPath, withCell cell: UICollectionViewCell) -> CGSize {
		return cell.viewSize()
	}
	
	func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: IndexPath, withCell cell: UICollectionViewCell) {
		shouldSelectCell(indexPath)
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
		self.view.backgroundColor = UIColor.primaryColor
		self.edgesForExtendedLayout = []

		self.viewModel.requestListHeroes(completionHandler: {
			self.bindViewModel()
			self.configureView()
		})
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	fileprivate func bindViewModel() {
		collectionViewBinding = CollectionViewBindingUtil(source: self.viewModel)
		collectionViewBinding?.bindFlowDelegateWithCollectionView(collectionView: collectionView)
		collectionViewBinding?.bindDatasourceWithCollectionView(collectionView: collectionView)
		
		viewModel.didSelectHandler = { [weak self] hero -> Void in
			let viewModel = HeroDetailViewModel(hero: hero)
			let controller = HeroDetailViewController(viewModel: viewModel)
			
			self?.navigationController?.pushViewController(controller, animated: true)
		}
	}
	
	fileprivate func configureCollectionView() {
		self.collectionView.layer.cornerRadius = 5
		self.collectionView.layer.masksToBounds = true
		self.collectionView.backgroundColor = UIColor.secondaryColor
		self.collectionView.showsVerticalScrollIndicator = false
		self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
		self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset
		self.collectionViewLayout.scrollDirection = .vertical
		
		self.collectionView.register(HeroMainCell.nib(), forCellWithReuseIdentifier: HeroMainCell.identifier())
	}
	
	fileprivate func setupConstraints() {
		self.setFilterViewConstraints()
		self.setSeparatorViewConstraints()
		self.setCollectionViewConstraints()
	}
	
	fileprivate func configureView() {
		view.addSubview(self.filterView)
		view.addSubview(self.collectionView)
		view.addSubview(self.separatorView)
				
		self.configureCollectionView()
		self.setupConstraints()
	}
	
	fileprivate func setFilterViewConstraints() {
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
						   constant: 20).isActive = true
		
		NSLayoutConstraint(item: filterView,
						   attribute: NSLayoutConstraint.Attribute.right,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.right,
						   multiplier: 1,
						   constant: -10).isActive = true
		
		NSLayoutConstraint(item: filterView,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: separatorView,
						   attribute: NSLayoutConstraint.Attribute.top,
						   multiplier: 1,
						   constant: -10).isActive = true
		
		NSLayoutConstraint(item: filterView,
						   attribute: NSLayoutConstraint.Attribute.height,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: nil,
						   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
						   multiplier: 1,
						   constant: filterView.viewSize().height).isActive = true
	}
	
	fileprivate func setSeparatorViewConstraints() {
		separatorView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint(item: separatorView,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: collectionView,
						   attribute: NSLayoutConstraint.Attribute.top,
						   multiplier: 1,
						   constant: -10).isActive = true
		
		NSLayoutConstraint(item: separatorView,
						   attribute: NSLayoutConstraint.Attribute.left,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.left,
						   multiplier: 1,
						   constant: 10).isActive = true
		
		NSLayoutConstraint(item: separatorView,
						   attribute: NSLayoutConstraint.Attribute.right,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.right,
						   multiplier: 1,
						   constant: -10).isActive = true
		
		NSLayoutConstraint(item: separatorView,
						   attribute: NSLayoutConstraint.Attribute.height,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: nil,
						   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
						   multiplier: 1,
						   constant: 3).isActive = true
	}
	
	fileprivate func setCollectionViewConstraints() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint(item: collectionView,
						   attribute: NSLayoutConstraint.Attribute.left,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.left,
						   multiplier: 1,
						   constant: 10).isActive = true
		
		NSLayoutConstraint(item: collectionView,
						   attribute: NSLayoutConstraint.Attribute.right,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.right,
						   multiplier: 1,
						   constant: -10).isActive = true
		
		NSLayoutConstraint(item: collectionView,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   multiplier: 1,
						   constant: -30).isActive = true
	}
}
