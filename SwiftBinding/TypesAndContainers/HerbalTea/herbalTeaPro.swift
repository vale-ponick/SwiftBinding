//
//  herbalTeaPro.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 04.10.2026.
//

import Foundation

// MARK: - '🍵🍓🌱 Herbal Tea' level Pro

protocol InfusablePro {
    var summary: String { get } // строка - описание, память НЕ выделяется
}

enum TeaMeasure {
    case piece, teaspoon, pinch
}

enum BrewingStep {
    case pourIn, addBoiledWater, letItBrew, pourInCap
    
    var actionText: String {
        switch self {
        case .pourIn: return "🌱 Pour in the ingredients into the teapot."
        case .addBoiledWater: return "♨️ Add boiling water."
        case .letItBrew: return "⏳ Let it brew for a few minutes."
        case .pourInCap: return "🍵 Pour into the teacup."
        }
    }
}
enum TeaBlend {
    case vitamin, relaxing, refreshing, floral
    
    var displayBlend: String {
        switch self {
        case .vitamin: return "🍓🫐🌿 Vitamin Tea with 🍯"
        case .refreshing: return "🌱🍋 Refreshing Tea"
        case .relaxing: return "🌿 Relax Tea"
        case .floral: return "🌸🍃🌼 Floral Tea"
        }
    }
}

enum BrewingError: Error {
    case waterTooCold(temperature: Int)
    case missingIngredient
    case melissaNotAllowed
}

enum BrewingStandard {
    static let minTemperature = 85
    static let maxTemperature = 100
    static let minBrewingTime = 5
}

struct BrewingStepDetails {
    let activity: BrewingStep
    let term: String?
    let temperature: Int?
    
    var fullDescription: String {
        var result = activity.actionText
        if let temperature {
            result += "🌡 \(temperature) °C"
        }
        if let term {
            result += "🕐 \(term)"
        }
        return result
    }
}
    
struct TeaLeaf: CustomStringConvertible { // вместо TeaIngredient -> 'заварка'
    let name: String
    let weight: Double
    let amount: Int
        
    var description: String {
        "\(name) - \(amount) x \(weight) g"
    }
}
    
struct TeaRecipePro: InfusablePro {
    let name: String
    let blend: TeaBlend
    let ingredients: [TeaLeaf]
    let steps: [BrewingStepDetails]
    
    var summary: String {
        "🍵 \(name) \(blend.displayBlend)"
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

func validate(recipe: TeaRecipePro) throws {
    guard !recipe.ingredients.isEmpty else {
        throw BrewingError.missingIngredient
    }
    
    guard let boilStep = recipe.steps.first(where: {$0.activity == .addBoiledWater }) else {
            throw BrewingError.waterTooCold(temperature: 0)
}
    
    if let temp = boilStep.temperature,
    temp < BrewingStandard.minTemperature {
        throw BrewingError.waterTooCold(temperature: temp)
    }
    guard !recipe.ingredients.contains(where: { $0.name.lowercased().contains("melissa") }) else {
        throw BrewingError.melissaNotAllowed
    }

func runTeaPro() {
    print("🍵🌱 Herbal Tea - level Pro")
    
    let vitamin = TeaRecipePro(
        name: "Vitamin",
        blend: .vitamin,
        ingredients: [
            TeaLeaf(name: "🍓 raspberry", weight: 5.0, amount: 1),
            TeaLeaf(name: "🍯 honey", weight: 1.0, amount: 1)
        ],
        steps: [
            BrewingStepDetails(activity: .pourIn, term: nil, temperature: nil),
            BrewingStepDetails(activity: .addBoiledWater, term: nil, temperature: 95),
            BrewingStepDetails(activity: .letItBrew, term: "10 min", temperature: nil),
            BrewingStepDetails(activity: .pourInCap, term: nil, temperature: 60),
        ])
    do {
        try validate(recipe: vitamin)
        print(vitamin.summary)
        print(vitamin.fullDescription)
    } catch BrewingError.missingIngredient {
        print("❌ Ошибка: В рецепте нет ни одного ингредиента! Нам нечего заваривать.")
    } catch BrewingError.waterTooCold(let temp) {
        print("❌ Ошибка заваривания: температура \(temp)°C слишком низкая! Травы не заварятся (нужно минимум \(BrewingStandard.minTemperature)°C).")
    } catch BrewingError.melissaNotAllowed {
        print("❌ Ошибка безопасности: Мелисса запрещена в этой лаборатории чая! Она усыпляет разработчиков. 😴")
    } catch {
        print("❌ Непредвиденная системная ошибка: \(error)")
    }
}
/**
 🍵🌱 Herbal Tea - level Pro
 🍵 Vitamin 🍓🫐🌿 Vitamin Tea with 🍯
 🍓 raspberry - 1 x 5.0 g
 🍯 honey - 1 x 1.0 g

 📋 Steps:
 1. 🌱 Pour in the ingredients into the teapot.
 2. ♨️ Add boiling water.🌡 95 °C
 3. ⏳ Let it brew for a few minutes.🕐 10 min
 4. 🍵 Pour into the teacup.🌡 60 °C
 */
