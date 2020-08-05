//
//  HeroDetailCellModelSpec.swift
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

class HeroDetailCellModelSpec: QuickSpec {
	
	override func spec() {
		
		var heroDetailCellModel: HeroDetailCellModel!
		var mockHero: Hero!
		
		beforeEach {
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
			
			heroDetailCellModel = HeroDetailCellModel(hero: mockHero)
		}
		
		afterEach {
			mockHero = nil
			heroDetailCellModel = nil
		}
		
		describe("Init") {
			
			context("view model") {
				
				it("should be have correct value") {
					let hero = heroDetailCellModel.hero.value
					expect(hero?.id).to(be(1))
					expect(hero?.localizedName).to(equal("Invoker"))
					expect(hero?.primaryAttr).to(equal(PrimaryAttr.Int))
					expect(hero?.attackType).to(equal(AttackType.Ranged))
					expect(hero?.roles).to(contain("Pusher"))
					expect(hero?.img).to(equal(""))
					expect(hero?.icon).to(equal(""))
					expect(hero?.baseHealth).to(equal(200))
					expect(hero?.baseMana).to(equal(150))
					expect(hero?.baseArmor).to(equal(-1.0))
					expect(hero?.baseAttackMin).to(equal(40))
					expect(hero?.baseAttackMax).to(equal(65))
					expect(hero?.moveSpeed).to(equal(300))
				}
			}
		}
	}
}
