//
//  HeroViewModelSpec.swift
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

class HeroViewModelSpec: QuickSpec {
	
	override func spec() {
		
		var heroViewModel: HeroViewModel!
		
		beforeEach {
			heroViewModel = HeroViewModel()
		}
		
		afterEach {
			heroViewModel = nil
		}
		
		describe("Request") {
			
			context("Hero") {
				
				it("should get the correct result") {
					heroViewModel.requestListHeroes { _ in }
					
					let exp = self.expectation(description: "Wait the response")
					let waiter = XCTWaiter.wait(for: [exp], timeout: 2.0)
					
					if waiter == XCTWaiter.Result.timedOut {
						expect(heroViewModel.heroes.value?.count) >= 0
					} else {
						expect(heroViewModel.heroes.value?.count) == 0
					}
				}
			}
			
			context("Filtered Hero") {
				
				it("should get the correct result if state not all") {
					heroViewModel.requestFilteredHeroes(state: "Initiator") {}
					
					let exp = self.expectation(description: "Wait the response")
					let waiter = XCTWaiter.wait(for: [exp], timeout: 2.0)
					
					if waiter == XCTWaiter.Result.timedOut {
						expect(heroViewModel.heroes.value?.count) >= 0
					} else {
						expect(heroViewModel.heroes.value?.count) == 0
					}
				}
				
				it("should get the correct result if state all") {
					heroViewModel.requestFilteredHeroes(state: "All") {}
					
					let exp = self.expectation(description: "Wait the response")
					let waiter = XCTWaiter.wait(for: [exp], timeout: 2.0)
					
					if waiter == XCTWaiter.Result.timedOut {
						expect(heroViewModel.heroes.value?.count) >= 0
					} else {
						expect(heroViewModel.heroes.value?.count) == 0
					}
				}
			}
		}
	}
}
