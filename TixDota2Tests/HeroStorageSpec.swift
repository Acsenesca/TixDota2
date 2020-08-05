//
//  HeroStorageSpec.swift
//  TixDota2Tests
//
//  Created by Stevanus Prasetyo Soemadi on 05/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import KeychainSwift

@testable
import TixDota2

typealias MockHeroStorageKey = HeroStorageSpec.MockHeroKey

class HeroStorageSpec: QuickSpec {
	
	enum MockHeroKey: String, CaseIterable {
		case heroList = "mock-hero-list"
	}
	
	override func spec() {
		var heroStorage: HeroStorage!
		var mockHero: Hero!
		
		beforeEach {
			heroStorage = HeroStorage.shared
			
			mockHero = Hero(
				id: 1,
				localizedName: "Invoker",
				primaryAttr: .Int,
				attackType: .Ranged,
				roles: ["Pusher", "Escape"],
				img: "",
				icon: "",
				baseHealth: 200,
				baseMana: 150,
				baseArmor: -1,
				baseAttackMin: 40,
				baseAttackMax: 65,
				moveSpeed: 300)
		}
		
		afterEach {
			heroStorage.removeAll()
			heroStorage = nil
			
			mockHero = nil
		}
		
		describe("Storage") {
			
			context("saving & loading") {
				
				it("should be have more than one value") {
					heroStorage.keychain = KeychainSwift()
					
					let heroListKey = MockHeroKey.heroList.rawValue
					
					heroStorage.save(value: [mockHero], key: heroListKey)
					
					let heroList = heroStorage.load(key:heroListKey)
					
					expect(heroList?.count) > 0
				}
				
				it("should be get the correct title") {
					heroStorage.keychain = KeychainSwift()
					
					let heroListKey = MockHeroKey.heroList.rawValue
					
					heroStorage.save(value: [mockHero], key: heroListKey)
					
					let heroList = heroStorage.load(key:heroListKey)
					
					expect(heroList?.first?.localizedName) == "Invoker"
				}
			}
			
			context("remove") {
				
				it("should be working properly") {
					heroStorage.keychain = KeychainSwift()
					
					let heroListKey = MockHeroKey.heroList.rawValue
					
					heroStorage.save(value: [mockHero], key: heroListKey)
					heroStorage.remove(key: heroListKey)
					
					let heroList = heroStorage.load(key:heroListKey)
					
					expect(heroList?.count) == 0
				}
			}
		}
	}
}
