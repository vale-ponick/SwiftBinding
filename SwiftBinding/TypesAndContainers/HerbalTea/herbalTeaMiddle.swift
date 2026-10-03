//
//  herbalTeaMiddle.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 03.10.2026.
//

import Foundation

//MARK: - 'Herbal tea': level Middle

//MARK: - Enums
protocol Infusable { // с англ. 'настаиваемый'
    var summary: String { get }
}

enum Measure { // чай штука, чайная ложка, щепотка
    case piece, teaspoon, pinch
}

// MARK: - Models

enum TeaStep {
    case pourIn, addBoilingWater, letItBrew
    
    var actionText: String {
        switch self {
        case .pourIn: return "🌱 Pour in the ingredients into the teapot."
        case .addBoilingWater:
            return "🫖 Add boiling water."
        case .letItBrew:
            return "🍵 Let it brew for a few minutes."
        }
    }
}

enum TeaName {
    case vitamin, flower, tonic, relax
    
    var displayName: String {
        switch self {
        case .vitamin: return "Vitamin Tea"
        case .flower: return "Flower Tea"
        case .relax: return "Relax Tea"
        case .tonic: return "Tonic Tea"
        }
    }
}

enum TeaError: Error {
    case waterTooCold(temperature: Int)
    case missingIngredients
}

struct TeaRecipeStep {
    let act: TeaStep
    let temperature: Int?
    
    var fullDescription: String {
        var result = act.actionText
        if let temperature {
            result += "🌡 \(temperature)"
        }
        return result
    }
}

struct TeaIngredient: CustomStringConvertible {
    let name: String
    let weight: Measure
    let quantity: Double
    
    var description: String {
        "\(name) - \(quantity) \(weight)"
    }
}

struct TeaRecipeMiddle: Infusable {
    let name: TeaName
    let ingredients: [TeaIngredient]
    let steps: [TeaRecipeStep]
    
    var summary: String {
        "This is a delicious recipe from Lusy's mom & Vale for '🍵🌱 \(name.displayName)'"
    }
    
    var fullDescription: String {
        var result = ""
        for ingredient in ingredients {
            result += ingredient.description + "\n"
        }
        result += "\n📋 Steps:\n"
        for(index, step) in steps.enumerated() {
            result += "\(index + 1). \(step.fullDescription)\n"
        }
        return result
    }
}

func checkBrewingSafety(recipe: TeaRecipeMiddle) throws {
    guard !recipe.ingredients.isEmpty else {
        throw TeaError.missingIngredients
    }
    // Всё ок, пропускаем дальше
}

    func runTeaSteps() {
        print(" Herbal tea recipe")
        let vitamin = TeaRecipeMiddle(name: .vitamin,
                                      ingredients: [TeaIngredient(
                                        name: "raspberry berries and leaves", weight: .piece, quantity: 5)],
                                      steps: [TeaRecipeStep(act: .addBoilingWater, temperature: 90)])
    
    print(vitamin.summary)
    print(vitamin.fullDescription)
}
/**
 Herbal tea recipe
This is a delicious recipe from Lusy's mom & Vale for '🍵🌱 Vitamin Tea'
raspberry berries and leaves - 5.0 piece

📋 Steps:
1. 🫖 Add boiling water.🌡 90
 */
