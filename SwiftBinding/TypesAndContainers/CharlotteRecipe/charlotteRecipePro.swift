//
//  charlotteRecipePro.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 01.10.2026.
//

import Foundation

// MARK: - 'CHARLOTTE RECIPE': level Pro

// TS: Validate the array of ingredients in the bowl. If Vale & Mama Lusia forgot to cut or add apples, added too much sugar, or messed up the proportions, the program should throw a hard custom exception (throw), which we'll safely handle at the top level in a do-catch block.

/**
 🧩 What concepts from our bindings are we practicing:
 1. Binding 6️⃣ ("Errors and Handling"): Creating an error matrix enum:Error, throws markers, the throw interrupt operator, and the do-catch safe zone.
 2. Binding 2️⃣ ("Data Security"): Using the guard operator to build a line of defense at function entry.
 3. Binding 4️⃣ ("Collections and Transformation"): The .first(where:) higher-order function for point-by-point search of the desired ingredient in an array without manual for loops.
 */

// MARK: - Data

protocol CookablePro {
    var summary: String { get } //
}

enum TableWeightsAndMeasuresPro {
    case piece, gram, glass, pinch, teaspoon, tablespoon
}

enum StepCooking {
    case beat, sift, cut, pourBase, layApples, pourTop, bake, cool, decorate
}

enum CharlotteError: Error {
    case applesNotCut
    case ingredientsMissing(name: String)
    case wrongProportions
}

struct RecipeStepPro {
    let action: StepCooking
    let description: String
    let duration: String?
    let temperature: Int?
    
    var fullDescription: String {
        var result = description
        if let duration {
            result += " ⏱ \(duration)"
        }
        if let temperature {
            result += " 🌡 \(temperature)°C"
        }
        return result
    }
}
   
struct IngredientCook: CustomStringConvertible {
    let name: String
    let weight: TableWeightsAndMeasuresPro
    let quantity: Double
    
    var description: String {
        "\(name) - \(quantity) \(weight)"
    }
}

struct RecipePro: CookablePro {
    let name: String
    let ingredients: [IngredientCook]
    let steps: [RecipeStepPro]
    
    var summary: String {
        "This is a delicious recipe from Lucy's mom & Vale for '\(name)':"
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

// MARK: Validation

func validate(_ recipe: RecipePro) throws {
    guard let eggs = recipe.ingredients.first(where: {  $0.name.contains("eggs") }) else {
        throw CharlotteError.ingredientsMissing(name:"eggs")
    }
    guard let sugar = recipe.ingredients.first(where: {  $0.name.contains("sugar") }) else {
        throw CharlotteError.ingredientsMissing(name:"sugar")
    }
    guard let flour = recipe.ingredients.first(where: {  $0.name.contains("flour") }) else {
        throw CharlotteError.ingredientsMissing(name:"flour")
    }
    guard let apples = recipe.ingredients.first(where: {  $0.name.contains("apples") }) else {
        throw CharlotteError.ingredientsMissing(name:"apples")
    }
    
    let k = eggs.quantity / 2
    
    guard sugar.quantity == 1 * k,
          flour.quantity == 1 * k,
          apples.quantity == 7 * k else {
        throw CharlotteError.wrongProportions
    }
    
    guard recipe.steps.contains(where: { $0.action == .cut }) else {
        throw CharlotteError.applesNotCut
    }
}

// MARK: - Run

    func runCharlottePro() {
        print("🥧 Charlotte Recipe")
        let recipe = RecipePro(name: "Charlotte",
                               ingredients: [IngredientCook(
                                name: "🥚 eggs", weight: .piece, quantity: 2),
                                             IngredientCook(name: "🍬 sugar", weight: .glass, quantity: 1),
                                             IngredientCook(name: "🥡 flour", weight: .glass, quantity: 1),
                                             IngredientCook(name: "🧂 salt", weight: .pinch, quantity: 1),
                                             IngredientCook(name: "🍂 cinnamon", weight: .pinch, quantity: 1.0),
                                             IngredientCook(name: "🌰 nutmeg", weight: .pinch, quantity: 1),
                                             IngredientCook(name: "🍏 apples", weight: .piece, quantity: 7),
                                             IngredientCook(name: "☁️ baking powder", weight: .teaspoon, quantity: 0.5),
                                             IngredientCook(name: "☁️ powdered sugar", weight: .tablespoon, quantity: 1.0)],
                               
                               steps: [RecipeStepPro (action: StepCooking.beat, description: "beat eggs with sugar", duration: "beat for about 15 min. until a thick, homogeneous foam appears", temperature: nil),
                                       RecipeStepPro(action: .sift, description: "Sift flour with baking powder and add", duration: nil, temperature: nil),
                                       RecipeStepPro(action: .cut, description: "Cut apples on pieces", duration: nil, temperature: nil),
                                       RecipeStepPro(action: .pourBase, description: "NB: grease the pan with oil", duration: nil, temperature: nil),
                                       RecipeStepPro(action: .layApples, description: "Sprinkle apples with cinnamon", duration: nil, temperature: nil),
                                       RecipeStepPro(action: .pourTop, description: "the apples should be covered with dough", duration: nil, temperature: nil),
                                       RecipeStepPro(action: .bake, description: "bake until golden brown", duration: "bake 45 min.", temperature: 180),
                                       RecipeStepPro(action: .cool, description: "cool for 20 min.", duration: nil, temperature: nil),
                                       RecipeStepPro(action: .decorate, description: "sprinkle powdered sugar", duration: nil, temperature: nil)
                                      ])
        do {
            try validate(recipe)
            print(recipe.summary)
            print(recipe.fullDescription)
        } catch {
            print("❌ Ошибка: \(error)")
        }
    }
