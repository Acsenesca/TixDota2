//
//  Hero.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 01/08/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation

struct Hero: Codable {
	let id: Int
	let localizedName: String?
	let primaryAttr: String?
	let attackType: String?
	let roles: [String]?
	let img: String?
	let icon: String?
	let baseHealth: Int?
	let baseMana: Int?
	let baseArmor: Float?
	let baseAttackMin: Int?
	let baseAttackMax: Int?
	let moveSpeed: Int?
	
	enum PropertyKey: String, CodingKey {
		case id = "id"
		case localizedName = "localized_name"
		case primaryAttr = "primary_attr"
		case attackType = "attack_type"
		case roles = "roles"
		case img = "img"
		case icon = "icon"
		case baseHealth = "base_health"
		case baseMana = "base_mana"
		case baseArmor = "base_armor"
		case baseAttackMin = "base_attack_min"
		case baseAttackMax = "base_attack_max"
		case moveSpeed = "move_speed"
	}
	
//	func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: PropertyKey.self)
//
//		try container.encode(id, forKey: .id)
//		try container.encode(localizedName, forKey: .localizedName)
//		try container.encode(primaryAttr, forKey: .primaryAttr)
//		try container.encode(attackType, forKey: .attackType)
//		try container.encode(roles, forKey: .roles)
//		try container.encode(img, forKey: .img)
//		try container.encode(icon, forKey: .icon)
//		try container.encode(baseHealth, forKey: .baseHealth)
//		try container.encode(baseMana, forKey: .baseMana)
//		try container.encode(baseArmor, forKey: .baseArmor)
//		try container.encode(baseAttackMin, forKey: .baseAttackMin)
//		try container.encode(baseAttackMax, forKey: .baseAttackMax)
//		try container.encode(moveSpeed, forKey: .moveSpeed)
//	}
	

//	init(id: Int, localizedName: String?, primaryAttr: String?, attackType: String?, roles: [String]?, img: String?, icon: String?, baseHealth: Int?, baseMana: Int?, baseArmor: Int?, baseAttackMin: Int?, baseAttackMax: Int?, moveSpeed: Int?) {
//        self.id = id
//        self.localizedName = localizedName
//        self.primaryAttr = primaryAttr
//        self.attackType = attackType
//        self.roles = roles
//		self.img = img
//		self.icon = icon
//		self.baseHealth = baseHealth
//		self.baseMana = baseMana
//		self.baseArmor = baseArmor
//		self.baseAttackMin = baseAttackMin
//		self.baseAttackMax = baseAttackMax
//		self.moveSpeed = moveSpeed
//    }
}
