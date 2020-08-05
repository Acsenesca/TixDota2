//
//  HeroDetailViewModel.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 05/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import ReactiveSwift

class HeroDetailViewModel: ViewModel {
	var hero: MutableProperty<Hero?> = MutableProperty(nil)
	
	init(hero: Hero?) {
		self.hero.value = hero
	}
}
