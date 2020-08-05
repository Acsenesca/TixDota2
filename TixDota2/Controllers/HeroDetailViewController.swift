//
//  HeroDetailViewController.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 02/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit
import ReactiveSwift

class HeroDetailViewController: UIViewController {
	typealias VM = HeroDetailViewModel
	var viewModel: VM
	
	lazy var detailView: DetailView = {
		let detailViewModel = DetailViewModel(hero: self.viewModel.hero.value)
		let view = DetailView.viewFromXib()
		view.bindViewModel(viewModel: detailViewModel)
		
		return view
	}()
	
	init(viewModel: HeroDetailViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.configureView()
	}
	
	private func configureView() {
		self.title = self.viewModel.hero.value?.localizedName
		
		edgesForExtendedLayout = []
		
		view.addSubview(self.detailView)
		
		self.setDetailViewConstraints()
	}
	
	private func setDetailViewConstraints() {
		self.detailView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint(item: detailView,
						   attribute: NSLayoutConstraint.Attribute.top,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.top,
						   multiplier: 1,
						   constant: 0).isActive = true
		
		NSLayoutConstraint(item: detailView,
						   attribute: NSLayoutConstraint.Attribute.left,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.left,
						   multiplier: 1,
						   constant: 0).isActive = true
		
		NSLayoutConstraint(item: detailView,
						   attribute: NSLayoutConstraint.Attribute.right,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.right,
						   multiplier: 1,
						   constant: 0).isActive = true
		
		NSLayoutConstraint(item: detailView,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   relatedBy: NSLayoutConstraint.Relation.equal,
						   toItem: view,
						   attribute: NSLayoutConstraint.Attribute.bottom,
						   multiplier: 1,
						   constant: 0).isActive = true
	}
}
