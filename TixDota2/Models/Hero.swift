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
	let attackType: AttackType?
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
}

enum AttackType: String, Codable {
	case Melee
	case Ranged
	case Undefined
}
