//
//  HeroStorage.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 03/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import KeychainSwift

typealias HeroStorageKey = HeroStorage.HeroKey

class HeroStorage {
	
	typealias Key = String
	typealias Value = [Hero]
	
	enum HeroKey: String, CaseIterable {
		case listOfHeroes = "list-of-heroes"
	}
	
	var keychain: KeychainSwift
	var keys: [String] = []
	
	static let shared = HeroStorage()
	
	init() {
		keychain = KeychainSwift()
	}
}

extension HeroStorage: CacheStorage {
	func save(value: [Hero], key: String) {
		keys.append(key)
		
		if let heroes = try? JSONEncoder().encode(value) {
			keychain.set(heroes, forKey: key)
		}
	}
	
	func load(key: HeroStorage.Key) -> [Hero]? {
		keychain.synchronizable = true
		let jsonString = keychain.get(key)
		var heroes: [Hero]? = []
		
		if let jsonStringNew = jsonString {
			let jsonData = Data(jsonStringNew.utf8)
			
			let decoder = JSONDecoder()
			do {
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let tempHeroes = try decoder.decode([Hero].self, from: jsonData)
				
				heroes = tempHeroes
			} catch {
				print(error.localizedDescription)
			}
		}
		
		return heroes
	}
	
	func remove(key: String) {
		keychain.delete(key)
	}
	
	func removeAll() {
		HeroKey.allCases.forEach { (key: HeroKey) in
			remove(key: key.rawValue)
		}
	}
}
