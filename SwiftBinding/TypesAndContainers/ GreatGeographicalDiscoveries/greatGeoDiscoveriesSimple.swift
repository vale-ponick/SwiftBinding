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
        "\(country.rawValue) - \(explorer) - \(year) - \(continent.rawValue) - \(significance.rawValue)"
    }
}
    
struct DiscoveryList: CustomStringConvertible {
    var discoveries: [Discovery] = []
    private var nextId: Int = 1
   
    mutating func add(place: String, explorer: String, year: Int, country: Country, continent: Continent, significance: Significance) {
        let new = Discovery(id: nextId, place: place, explorer: explorer, year: year, country: country, continent: continent, significance: significance)
        discoveries.append(new)
        nextId += 1
    }
    var description: String {
        var result = "\nGreat Geo Discoveries:\n"
        for (index, discovery) in discoveries.enumerated() {
            result += "\(index + 1). \(discovery.description)\n"
        }
        return result
    }
}

func runList() {
    var list = DiscoveryList()
    
    list.add(
        place: "rounded the Cape of Good Hope at the southern tip of Africa", explorer: "Bartolomeu Dias", year: 1488, country: .portugal, continent: .africa, significance: .global)
    
    list.add(
        place: "New World (America)", explorer: "Christopher Columbus", year: 1492, country: .spain, continent: .southAmerica, significance: .global)
    list.add(
        place: "expedition completed the first circumnavigation of the Earth", explorer: "Ferdinand Magellan", year: 1522, country: .spain, continent: .africa, significance: .global)
    
    print(list)
}
