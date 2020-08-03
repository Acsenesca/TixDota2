//
//  CacheStorage.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 03/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation

protocol CacheStorage {
	associatedtype Key
	associatedtype Value
	
	func save(value: Value, key: Key)
	
	func load(key: Key) -> Value?
	
	func remove(key: Key)
	
	func removeAll()
}
