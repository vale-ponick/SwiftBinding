//
//  charlotteRecipeMiddle.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 29.09.2026.
//

import Foundation

/**
 🧩 What concepts from our bindings are we practicing:
 1. Binding 6️⃣ ("Errors and Handling"): Creating an error matrix enum:Error, throws markers, the throw interrupt operator, and the do-catch safe zone.
 2. Binding 2️⃣ ("Data Security"): Using the guard operator to build a line of defense at function entry.
 3. Binding 4️⃣ ("Collections and Transformation"): The .first(where:) higher-order function for point-by-point search of the desired ingredient in an array without manual for loops.
 */
// MARK: - 'Charlotte Recipe': level Middle
// tool Middle: enum, struct, protocol, computed property, func, print + enum Step, + struct RecipeStep, + [RecipeStep] + .enumerated().

protocol CookableMiddle {
    var summary: String { get } //
}
enum TableWeightsAndMeasuresMiddle {
    case piece, gram, glass, pinch, teaspoon, tablespoon
}
enum Step {
    case beat, sift, cut, pourBase, layApples, pourTop, bake, cool, decorate
}
struct RecipeStep {
    let action: Step
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
   
struct IngredientCooking: CustomStringConvertible {
    let name: String
    let weight: TableWeightsAndMeasuresMiddle
    let quantity: Double
    
    var description: String {
        "\(name) - \(quantity) \(weight)"
    }
}
struct RecipeMiddle: CookableMiddle {
    let name: String
    let ingredients: [IngredientCooking]
    let steps: [RecipeStep]
    
    var summary: String {
        "This is a delicious recipe from Lucy's mom & Vale for 🥧 '\(name)':"
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

// MARK: - Run
func runStepsCooking() {
    print("🥧 Charlotte Recipe")
    let recipe = RecipeMiddle(name: "🥧 Charlotte",
                              ingredients: [IngredientCooking(
                                name: "🥚 eggs", weight: .piece, quantity: 2),
                                            IngredientCooking(name: "🍬 sugar", weight: .glass, quantity: 1),
                                            IngredientCooking(name: "🥡 flour", weight: .glass, quantity: 1),
                                            IngredientCooking(name: "🧂 salt", weight: .pinch, quantity: 1),
                                            IngredientCooking(name: "🍂 cinnamon", weight: .pinch, quantity: 1.0),
                                            IngredientCooking(name: "🌰 nutmeg", weight: .pinch, quantity: 1),
                                            IngredientCooking(name: "🍏 apple", weight: .piece, quantity: 7),
                                            IngredientCooking(name: "☁️ baking powder", weight: .teaspoon, quantity: 0.5),
                                            IngredientCooking(name: "☁️ powdered sugar", weight: .tablespoon, quantity: 1.0)],
                              
                              steps: [RecipeStep(action: Step.beat, description: "beat eggs with sugar", duration: "beat for about 15 min. until a thick, homogeneous foam appears", temperature: nil),
                                      RecipeStep(action: .sift, description: "Sift flour with baking powder and add", duration: nil, temperature: nil),
                                      RecipeStep(action: .cut, description: "Cut apples on pieces", duration: nil, temperature: nil),
                                      RecipeStep(action: .pourBase, description: "NB: grease the pan with oil", duration: nil, temperature: nil),
                                      RecipeStep(action: .layApples, description: "Sprinkle apples with cinnamon", duration: nil, temperature: nil),
                                      RecipeStep(action: .pourTop, description: "the apples should be covered with dough", duration: nil, temperature: nil),
                                      RecipeStep(action: .bake, description: "bake until golden brown", duration: "bake 45 min.", temperature: 180),
                                      RecipeStep(action: .cool, description: "cool for 20 min.", duration: nil, temperature: nil),
                                      RecipeStep(action: .decorate, description: "sprinkle powdered sugar", duration: nil, temperature: nil)
                                     ])
    
    
    print(recipe.summary)
    print(recipe.fullDescription)
}
/*
 🥧 Charlotte Recipe from Lucy's mom & Vale  - level Middle
 This is a delicious recipe from Lucy's mom & Vale for 'Charlotte':
 🥚 eggs - 2.0 piece
 🍬 sugar - 1.0 glass
 🥡 flour - 1.0 glass
 🧂 salt - 1.0 pinch
 🍂 cinnamon - 1.0 pinch
 🌰 nutmeg - 1.0 pinch
 🍏 apple - 7.0 piece
 ☁️ baking powder - 0.5 teaspoon
 ☁️ powdered sugar - 1.0 tablespoon

 📋 Steps:
 1. beat eggs with sugar ⏱ beat for about 15 min. until a thick, homogeneous foam appears
 2. Sift flour with baking powder and add
 3. Cut apples on pieces
 4. NB: grease the pan with oil
 5. Sprinkle apples with cinnamon
 6. the apples should be covered with dough
 7. bake until golden brown ⏱ bake 45 min. 🌡 180°C
 8. cool for 20 min.
 9. sprinkle powdered sugar
 */
