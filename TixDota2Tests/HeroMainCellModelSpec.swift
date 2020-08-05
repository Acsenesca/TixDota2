//
//  HeroMainCellModelSpec.swift
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

class HeroMainCellModelSpec: QuickSpec {
	
	override func spec() {
		
		var heroMainCellModel: HeroMainCellModel!
		var mockHero: Hero!
		
		beforeEach {
			mockHero = Hero(
				id: 1,
				localizedName: "Invoker",
				primaryAttr: .Int,
				attackType: .Ranged,
				roles: [""],
				img: "",
				icon: "",
				baseHealth: 10,
				baseMana: 10,
				baseArmor: 10,
				baseAttackMin: 7,
				baseAttackMax: 10,
				moveSpeed: 10)
			
			heroMainCellModel = HeroMainCellModel(hero: mockHero)
		}
		
		afterEach {
			mockHero = nil
			heroMainCellModel = nil
		}
		
		describe("Init") {
			
			context("view model") {
				
				it("should be have correct value") {
					let hero = heroMainCellModel.hero.value
					expect(hero?.localizedName).to(be("Invoker"))
				}
			}
		}
	}
}

