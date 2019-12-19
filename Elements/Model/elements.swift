//
//  elements.swift
//  Elements
//
//  Created by Margiett Gil on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementSearch: Codable {
    let results: [Element]
}

struct Element: Codable {
    let name: String
    let number: Int
    let symbol: String
    let source: String
    let atomic_mass: Double
    let melt: Double?
    let boil: Double?
    let discoveredBy: String?
    let id: String?
    let favoritedBy: String?
    
    enum CodingKeys: String, CodingKey {
    case discoveredBy = "discovered_by"
    case melt = "melt"
    case boil = "boil"
    case symbol = "symbol"
    case name = "name"
    case number = "number"
    case id = "id"
    case favoritedBy// = "favorited_by"
    case source = "source"
    case atomic_mass = "atomic_mass"
}
}
