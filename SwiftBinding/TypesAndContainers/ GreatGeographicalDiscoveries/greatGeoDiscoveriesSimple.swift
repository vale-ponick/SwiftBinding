//
//  greatGeoDiscoveriesSimple.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 12.10.2026.
//

import Foundation

// TS: 'Great Geo Discoveries' - Simple

enum Country: String {
    case portugal = "Portugal"
    case spain = "Spain"
    case russia = "Russia"
}

enum Continent: String {
    case africa = "Africa"
    case northAmerica = "North America"
    case southAmerica = "South America"
    case asia = "Asia"
    case europe = "Europe"
}

enum Significance: String {
    case local = "local"
    case region = "region"
    case global = "🌍 global"
}

struct Discovery: CustomStringConvertible {
    let id: Int
    let place: String
    let explorer: String
    let year: Int
    let country: Country
    let continent: Continent
    let significance: Significance
    
    var description: String {
        "\(country) - \(explorer)"
    }
}
    
struct DiscoveryList {
    var discoveries: [Discovery] = []
    private var nextId: Int = 1
   
    mutating func add(place: String, explorer: String, year: Int, country: Country, continent: Continent, significance: Significance) {
        let new = Discovery(id: nextId, place: place, explorer: explorer, year: year, country: country, continent: continent, significance: significance)
        discoveries.append(new)
        nextId += 1
    }
}


