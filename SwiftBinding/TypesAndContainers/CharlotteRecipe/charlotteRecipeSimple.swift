//
//  charlotteRecipeSimple.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 29.09.2026.
//

import Foundation

/// MARK: - '🍎 CHARLOTTE RECIPE': level Simple
// Tools: enum, struct, protocol, computed property, print

// MARK: - Data

protocol Cookable { // техническое задание(интерфейс-контракт), который описывает, какими свойствами и методами должен обладать объект, но сам по себе этот протокол ничего не реализует.
    var summary: String { get } // ставит условие(требование): «Каждый, кто подпишет контракт Cookable, обязан предоставить мне готовую строку типа String».
}

enum TableWeightsAndMeasures {
    case piece, gram, glass, pinch, teaspoon, tablespoon
}

struct Ingredient: CustomStringConvertible {
    let name: String
    let weight: TableWeightsAndMeasures
    let quantity: Double

    var description: String {
        "\(name) - \(quantity) \(weight)"
    }
}

struct Recipe: Cookable {
    let name: String
    let ingredients: [Ingredient]
    let time: Int
    let temperature: Int

    var summary: String {
        "This is a delicious recipe for '\(name)':"
    }

    var fullDescription: String {
        var result = ""
        for ingredient in ingredients {
            result += ingredient.description + "\n"
        }
        result += "⏰ Baking time: \(time) min.\n"
        result += "🔥 Temperature: \(temperature)°C"
        return result
    }
}

// MARK: - Run

func runCharlotte() {
    print("🍏 EASY: Charlotte Recipe — level Simple")

    let charlotte = Recipe(
        name: "🍏🥧 Charlotte",
        ingredients: [
            Ingredient(name: "🥚 eggs", weight: .piece, quantity: 2),
            Ingredient(name: "🍬 sugar", weight: .glass, quantity: 1),
            Ingredient(name: "🥡 flour", weight: .glass, quantity: 1),
            Ingredient(name: "🧂 salt", weight: .pinch, quantity: 1),
            Ingredient(name: "🍂 cinnamon", weight: .pinch, quantity: 1.0),
            Ingredient(name: "🌰 nutmeg", weight: .pinch, quantity: 1),
            Ingredient(name: "🍏 apple", weight: .piece, quantity: 7),
            Ingredient(name: "☁️ baking powder", weight: .teaspoon, quantity: 0.5),
            Ingredient(name: "☁️ powdered sugar", weight: .tablespoon, quantity: 1.0)
        ],
        time: 45,
        temperature: 180
    )

    print(charlotte.summary)
    print(charlotte.fullDescription)
}
/*
 This is a delicious recipe for '🍏🥧 Charlotte':
 🥚 eggs - 2.0 piece
 🍬 sugar - 1.0 glass
 🥡 flour - 1.0 glass
 🧂 salt - 1.0 pinch
 🍂 cinnamon - 1.0 pinch
 🌰 nutmeg - 1.0 pinch
 🍏 apple - 7.0 piece
 ☁️ baking powder - 0.5 teaspoon
 ☁️ powdered sugar - 1.0 tablespoon
 ⏰ Baking time: 45 min.
 🔥 Temperature: 180°C
 */
