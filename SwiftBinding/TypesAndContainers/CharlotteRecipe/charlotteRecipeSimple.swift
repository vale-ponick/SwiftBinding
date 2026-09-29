//
//  charlotteRecipeSimple.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 29.09.2026.
//

import Foundation

/// MARK: - 🍎 CHARLOTTE RECIPE — Variant 1 (Simple)
// Tools: enum, struct, protocol, computed property, print

// MARK: - Data

protocol CookableV1 {
    var summary: String { get }
}

enum TableWeightsAndMeasuresV1 {
    case piece, gram, glass, pinch, teaspoon, tablespoon
}

struct IngredientV1: CustomStringConvertible {
    let name: String
    let weight: TableWeightsAndMeasuresV1
    let quantity: Double

    var description: String {
        "\(name) - \(quantity) \(weight)"
    }
}

struct RecipeV1: CookableV1 {
    let name: String
    let ingredients: [IngredientV1]
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

func runCharlotteV1() {
    print("🍏 EASY: Charlotte Recipe — Variant 1 (Simple)")

    let charlotte = RecipeV1(
        name: "🍏🥧 Charlotte",
        ingredients: [
            IngredientV1(name: "🥚 eggs", weight: .piece, quantity: 2),
            IngredientV1(name: "🍬 sugar", weight: .glass, quantity: 1),
            IngredientV1(name: "🥡 flour", weight: .glass, quantity: 1),
            IngredientV1(name: "🧂 salt", weight: .pinch, quantity: 1),
            IngredientV1(name: "🍂 cinnamon", weight: .pinch, quantity: 1.0),
            IngredientV1(name: "🌰 nutmeg", weight: .pinch, quantity: 1),
            IngredientV1(name: "🍏 apple", weight: .piece, quantity: 7),
            IngredientV1(name: "☁️ baking powder", weight: .teaspoon, quantity: 0.5),
            IngredientV1(name: "☁️ powdered sugar", weight: .tablespoon, quantity: 1.0)
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
