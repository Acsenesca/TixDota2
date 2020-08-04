//
//  DetailView.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 31/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit
import ReactiveSwift

class DetailViewModel: ViewModel {
	let hero: MutableProperty<Hero?> = MutableProperty(nil)
	let similiarHeroes: MutableProperty<[Hero]?> = MutableProperty(nil)
	
	init(hero: Hero?) {
		self.hero.value = hero
	}
	
	fileprivate func requestSimiliarHeroes(completionHandler: @escaping () -> Void) {
		let storage = HeroStorage()
		let listOfHeroes = storage.load(key: HeroStorageKey.listOfHeroes.rawValue)

		guard let hero = self.hero.value else { return }

		let filteredHeroes = listOfHeroes?.filter {
			($0.roles == hero.roles) &&
			($0.primaryAttr == hero.primaryAttr) &&
			($0.id != hero.id)
		}
		
		let sortedHeroes = filteredHeroes?.sorted(by: {
			if hero.primaryAttr == PrimaryAttr.Agi {
				return $0.moveSpeed ?? 0 > $1.moveSpeed ?? 0
			} else if hero.primaryAttr == PrimaryAttr.Str {
				return $0.baseAttackMax ?? 0 > $1.baseAttackMax ?? 0
			} else if hero.primaryAttr == PrimaryAttr.Int {
				return $0.baseMana ?? 0 > $1.baseMana ?? 0
			} else {
				return false
			}
		})
		
		if let count = sortedHeroes?.count {
			if count == 1 {
				self.similiarHeroes.value = sortedHeroes
			} else if count > 0 && count <= 3 {
				self.similiarHeroes.value = Array(sortedHeroes?[0...count-1] ?? [])
			}
		}
	}
}

extension DetailViewModel: SectionedCollectionSource, SizeCollectionSource {
	func numberOfCollectionCellAtSection(section: Int) -> Int {
		return self.similiarHeroes.value?.count ?? 0
	}
	
	func collectionCellIdentifierAtIndexPath(indexPath: IndexPath) -> String {
		return HeroDetailCell.identifier()
	}
	
	func collectionCellModelAtIndexPath(indexPath: IndexPath) -> ViewModel {
		return HeroDetailCellModel(hero: self.similiarHeroes.value?[indexPath.row])
	}
	
	func cellClassAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell.Type {
		return HeroDetailCell.self
	}
	
	func cellSizeAtIndexPath(indexPath: IndexPath, withCell cell: UICollectionViewCell) -> CGSize {
		return cell.viewSize()
	}
}

class DetailView: UIView, ViewBinding {

	@IBOutlet weak var heroMainImageView: UIImageView!
	@IBOutlet weak var heroTypeImageView: UIImageView!
	@IBOutlet weak var heroNameLabel: UILabel!
	@IBOutlet weak var rolesLabel: UILabel!
	
	@IBOutlet weak var baseAttackLabel: UILabel!
	@IBOutlet weak var baseArmorLabel: UILabel!
	@IBOutlet weak var moveSpeedLabel: UILabel!
	@IBOutlet weak var baseHealthLabel: UILabel!
	@IBOutlet weak var baseManaLabel: UILabel!
	@IBOutlet weak var attributeLabel: UILabel!
	
	@IBOutlet weak var collectionView: UICollectionView!
	private var collectionViewBinding: CollectionViewBindingUtil<DetailViewModel>?

	typealias VM = DetailViewModel
	var viewModel: VM?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func bindViewModel(viewModel: VM?) {
		self.viewModel = viewModel
	
		if let vm = self.viewModel {
			collectionViewBinding = CollectionViewBindingUtil(source: vm)
			collectionViewBinding?.bindFlowDelegateWithCollectionView(collectionView: collectionView)
			collectionViewBinding?.bindDatasourceWithCollectionView(collectionView: collectionView)
			
			configureCollectionView()
			vm.requestSimiliarHeroes(completionHandler: {})
		}		

		self.configureView()
	}
	
	fileprivate func configureCollectionView() {
		self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
		self.collectionView.backgroundColor = UIColor.clear
		self.collectionView.isScrollEnabled = true
		self.collectionView.register(HeroDetailCell.nib(), forCellWithReuseIdentifier: HeroDetailCell.identifier())
	}
	
	fileprivate func configureView() {
		let placeholder = UIImage(named: "pic-default-profilepict")
		self.heroMainImageView.kf.indicatorType = .activity
		
		guard let hero = self.viewModel?.hero.value else { return }
		
		if let imageUrl = hero.img, let url = URL(string: imageBaseUrl + imageUrl) {
			self.heroMainImageView.kf.setImage(with: url, placeholder: placeholder)
		} else {
			self.heroMainImageView.image = placeholder
		}
		
		if let attackType = hero.attackType {
			if  attackType == AttackType.Ranged {
				self.heroTypeImageView.image = UIImage(named: "ico-ranged")
			} else {
				self.heroTypeImageView.image = UIImage(named: "ico-melee")
			}
		} else {
			self.heroTypeImageView.image = placeholder
		}

		if let baseAttackMin = hero.baseAttackMin, let baseAttackMax = hero.baseAttackMax {
			self.baseAttackLabel.text = "\(String(describing: baseAttackMin)) - \(String(describing: baseAttackMax))"
		}
		
		if let baseArmor = hero.baseArmor {
			self.baseArmorLabel.text = "\(String(describing: baseArmor))"
		}
		
		if let moveSpeed = hero.moveSpeed {
			self.moveSpeedLabel.text = "\(String(describing: moveSpeed))"
		}
		
		if let baseHealth = hero.baseHealth {
			self.baseHealthLabel.text = "\(String(describing: baseHealth))"
		}
		
		if let baseMana = hero.baseMana {
			self.baseManaLabel.text = "\(String(describing: baseMana))"
		}
		
		self.attributeLabel.text = hero.primaryAttr?.rawValue
		self.heroNameLabel.text = hero.localizedName
		self.rolesLabel.text = hero.roles?.joined(separator:", ")
	}
}
