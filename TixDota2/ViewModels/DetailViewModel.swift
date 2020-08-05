//
//  DetailViewModel.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 05/08/20.
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
	
	func requestSimiliarHeroes(completionHandler: @escaping () -> Void) {
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
