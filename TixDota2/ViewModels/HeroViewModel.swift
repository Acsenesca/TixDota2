//
//  HeroViewModel.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 05/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import UIKit

class HeroViewModel: ViewModel {
	var heroes: MutableProperty<[Hero]?> = MutableProperty(nil)
	var didSelectHandler: ((Hero) -> Void) = {_ in }
	var filterStates: [String] = ["All"]
	var selectedState: String = "All"
	var shouldShowAlert: Bool = false
	
	init() { }
	
	func requestListHeroes(completionHandler: @escaping (Bool) -> Void) {
		AF.request(listHeroAPIUrl).responseJSON{ response in
			switch (response.result) {
			case .success:
				if let data = response.data {
					do {
						let storage = HeroStorage()
						let decoder = JSONDecoder()
						decoder.keyDecodingStrategy = .convertFromSnakeCase
						let jsonData = try decoder.decode([Hero].self, from: data)
						
						storage.removeAll()
						storage.save(value: jsonData, key: HeroStorageKey.listOfHeroes.rawValue)

						self.heroes.value = jsonData

						let flattenedArray = jsonData.map { ($0.roles ?? []) }.reduce([], +)
						self.filterStates = self.filterStates + Array(Set(flattenedArray)).sorted()

						completionHandler(false)
					} catch {
						print(error.localizedDescription)
					}
				}
			case .failure( _):
				let storage = HeroStorage()
				let heroes = storage.load(key: HeroStorageKey.listOfHeroes.rawValue)
				
				if let values = heroes {
					let flattenedArray = values.map { ($0.roles ?? []) }.reduce([], +)
					self.filterStates = self.filterStates + Array(Set(flattenedArray)).sorted()
				}
				
				completionHandler(true)
			}
		}
	}
	
	fileprivate func shouldSelectCell(_ indexPath: IndexPath) {
		guard let hero = self.heroes.value?[indexPath.row] else { return }
		
		self.didSelectHandler(hero)
	}
	
	func requestFilteredHeroes(state: String, completionHandler: @escaping () -> Void) {
		let storage = HeroStorage()
		let listOfHeroes = storage.load(key: HeroStorageKey.listOfHeroes.rawValue)
		
		if state != "All" {
			let filteredHeroes = listOfHeroes?.filter {
				var tempRoles: [String] = []
				
				if let roles = $0.roles {
					tempRoles = roles
				}
				
				return tempRoles.contains(state)
			}
			
			self.heroes.value = filteredHeroes

		} else {
			self.heroes.value = listOfHeroes
		}
		
		completionHandler()
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
