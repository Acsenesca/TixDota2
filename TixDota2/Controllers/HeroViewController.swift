//
//  HeroViewController.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 30/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit

class HeroViewController: UIViewController {
	typealias VM = HeroViewModel
	var viewModel: VM
	
	lazy var collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	lazy var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.collectionViewLayout)
	private var collectionViewBinding: CollectionViewBindingUtil<HeroViewModel>?
	
	lazy var filterView: FilterView = {
		let viewModel = FilterViewModel(states: self.viewModel.filterStates)
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

		self.bindViewModel()
		self.configureView()
		self.configureNotification()
		self.configureAlertView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	private func bindViewModel() {
		collectionViewBinding = CollectionViewBindingUtil(source: self.viewModel)
		collectionViewBinding?.bindFlowDelegateWithCollectionView(collectionView: collectionView)
		collectionViewBinding?.bindDatasourceWithCollectionView(collectionView: collectionView)
		
		viewModel.didSelectHandler = { [weak self] hero -> Void in
			let viewModel = HeroDetailViewModel(hero: hero)
			let controller = HeroDetailViewController(viewModel: viewModel)
			
			self?.navigationController?.pushViewController(controller, animated: true)
		}
	}
	
	private func configureCollectionView() {
		self.collectionView.layer.cornerRadius = 5
		self.collectionView.layer.masksToBounds = true
		self.collectionView.backgroundColor = UIColor.secondaryColor
		self.collectionView.showsVerticalScrollIndicator = false
		self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
		self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset
		self.collectionViewLayout.scrollDirection = .vertical
		
		self.collectionView.register(HeroMainCell.nib(), forCellWithReuseIdentifier: HeroMainCell.identifier())
	}
	
	private func configureNotification() {
		NotificationCenter.default.addObserver(forName: .filterTapped, object: nil, queue: nil, using: {[weak self] (notification) -> Void in
			guard let state = notification.userInfo?["state"] as? String else {
				return
			}
			
			self?.viewModel.selectedState = state
			self?.resetCollectionView()
		})
	}
	
	private func resetCollectionView() {
		self.viewModel.requestFilteredHeroes(state: self.viewModel.selectedState, completionHandler: {
			self.title = self.viewModel.selectedState
			self.collectionView.reloadData()
		})
	}

	private func setupConstraints() {
		self.setFilterViewConstraints()
		self.setSeparatorViewConstraints()
		self.setCollectionViewConstraints()
	}
	
	private func configureView() {
		view.addSubview(self.filterView)
		view.addSubview(self.collectionView)
		view.addSubview(self.separatorView)
				
		self.configureCollectionView()
		self.setupConstraints()
	}
	
	private func configureAlertView() {
		if self.viewModel.shouldShowAlert {
			let alert = UIAlertController(title: "Unable to Verify Update Data", message: "Currently only use local data. Please check your connection. ", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	private func setFilterViewConstraints() {
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
	
	private func setSeparatorViewConstraints() {
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
	
	private func setCollectionViewConstraints() {
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
