//
//  herbalTeaSimple.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 02.10.2026.
//

import Foundation

// MARK: - "🍵🌿 Herbal tea': level Simple
// Tools: enum, struct, protocol, computed property, print

// MARK: - DATA

protocol Brewable {  // с англ. 'пригодный для заваривания'
    var summary: String { get }
}

enum HerbType: String {
    case mint = "mint"
    case oregano = "oregano"
    case stJohnsWort = "St. John's wort"
    case thyme = "thyme"
    case melissa = "melissa"
}

struct Herb: CustomStringConvertible {
    let name: HerbType
    let quantity: Int
    
    var description: String {
        "\(name.rawValue) - \(quantity)"
    }
}

struct TeaRecipe: Brewable {
    let name: String
    let herbs: [Herb]
    let time: Int
    let brewingTemperature: Int
    
    var summary: String {
        "This is a recipe 'Herb tea' from Lucy's mom & Vale for '\(name)':"
    }
    
    var fullDescription: String {
        var result = ""
        for herb in herbs {
            result += herb.description + "\n"
        }
        result += "Infusion time: \(time) min.\n"
        result += "Brewing temperature: \(brewingTemperature)°C"
        return result
    }
}

// MARK: - Run

func runHerbalTea() {
    print("🍵🌿 Herbal tea - level Simple")
    
    let tea = TeaRecipe(name: "Calming tea", herbs: [
        Herb(name: .mint, quantity: 1),
        Herb(name: .oregano, quantity: 1),
        Herb(name: .stJohnsWort, quantity: 1)
        ],
        time: 15, brewingTemperature: 90
    )
    
    print(tea.summary)
    print(tea.fullDescription)
}
/**
 Herbal tea - level Simple
 This is a recipe 'Herb tea' from Lucy's mom & Vale for 'Calming tea':
 mint - 1
 oregano - 1
 St. John's wort - 1
 Infusion time: 15 min.
 Brewing temperature: 90°C
 */
