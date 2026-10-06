//
//  bilboMeetsGandalfMiddle.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 04.10.2026.
//

import Foundation

// MARK: -  'Bilbo Meets Gandalf' - Middle

/** 🎬 Plot
 Gandalf comes to Bilbo. They smoke pipes and chat. At first, Bilbo sees only an old man with a staff and remains unaware of his identity.
 But when Gandalf reveals his name, Bilbo recognizes the wizard, remembers his legendary fireworks, and is deeply inspired.
 Despite his admiration, Bilbo politely declines the invitation to a mad adventure, but extends a warm invitation to tea. */
 
 // MARK: - 🛠️ Tools & Syntactic Bonds
 /*
  — protocol (IdentityDescribable for custom summary representation)
  — enum + computed properties (DescribableMiddle, SpeciesMiddle, PersonMiddle, QualityMiddle)
  — switch 
  — Higher-Order Functions: .map, .joined(separator:) for seamless traits transformation
  — mutating func (Dynamic data mutation within value types)
  — Logical branching (if-else state control)
  */

// MARK: - ⚙️ Инженерная суть
/*
 — Управление изменяемостью состояния:
   Переход от статического представления данных к динамической модели состояния на основе типов значений (Value Types) с использованием изменяемых свойств `var` вместо фиксированных констант `let`.
 
 — Инкапсулированная мутация состояния:
   Реализация внутренних изменений состояния с помощью ключевого слова `mutating`, что гарантирует безопасную модификацию свойств структуры из контекста её собственных методов.
 
 — Разделение данных и отображения:
   Сохранение структур легковесными и узкоспециализированными только для хранения данных; перенос всей текстовой логики и локализации признаков в выделенные перечисления (enum).
 
 — Функциональный конвейер обработки коллекций:
   Полный отказ от примитивных циклов ручного накопления данных `for-in` в пользу трансформации коллекций через метод `.map` и последующего слияния строковых сегментов с помощью `.joined`.
 */

protocol DescribableMiddle {
    var summary: String { get }
}

enum SpeciesMiddle {
    case hobbit, wizard
    
    var displaySpecies: String {
        switch self {
        case .hobbit: return "hobbit"
        case .wizard: return "wizard"
        }
    }
}

enum PersonMiddle {
    case bilbo, gandalf
    
    var displayPerson: String {
        switch self {
        case .bilbo: return "Bilbo Baggins"
        case .gandalf: return "Gandalf"
        }
    }
}

enum QualityMiddle {
    case smokePipe, loveComfort, loveAdventure
    
    var displayQuality: String {
        switch self {
        case .smokePipe: return "smokes a pipe"
        case .loveComfort: return "loves comfort"
        case .loveAdventure: return "loves adventures"
        }
    }
}

struct PersonMeets: DescribableMiddle {
    let name: PersonMiddle
    let species: SpeciesMiddle
    let age: Int?
    let appearance: String?
    let quality: [QualityMiddle]
    
    var isAwareOfGandalf: Bool = false
    var isAdventureAccept: Bool = false
    
    var summary: String {
        var result = "\(name.displayPerson) - \(species.displaySpecies)"
        
        if let age {
            result += ", \(age) years old"
        }
        return result
    }
    
    var fullDescription: String {
        var result = summary
        if let appearance {
            result += ", \(appearance)"
        }
        result += "\nTraits: " + quality.map { $0.displayQuality }.joined(separator: ", ")
        result += "\nAware of Gandalf: \(isAwareOfGandalf)"
        result += "\nAdventure accepted: \(isAdventureAccept)"
        return result
    }
    
    mutating func hearTheName() {
        isAwareOfGandalf = true
        print("🍃 Bilbo: My God! That same Gandalf!")
    }
    
    mutating func respondAdventure() {
        isAdventureAccept = false
        print("🍃 Bilbo: I don't feel like an adventure, thank you! But come for tea tomorrow!")
    }
}
    
func runBilboMeetsGandalfMiddle() {
    var bilbo = PersonMeets(name: .bilbo, species: .hobbit, age: 50, appearance: "short, well-fed, curly hair, bare feet", quality: [.loveComfort, .smokePipe])
        
    bilbo.hearTheName()
    bilbo.respondAdventure()
    print("\nFinal status Bilbo Baggins: ")
    print(bilbo.fullDescription)
}
/**
 Final status Bilbo Baggins:
 Bilbo Baggins - hobbit, 50 years old, short, well-fed, curly hair, bare feet
 Traits: loves comfort, smokes a pipe
 Aware of Gandalf: true
 Adventure accepted: false
 */
