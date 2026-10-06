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
  — enum + computed properties (Race, Person, QualityMember for zero-hardcode text data)
  — switch + where (exhaustive checking inside enums)
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
        case .hobbit: return "Hobbit"
        case .wizard: return "Wizard"
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
        case .smokePipe: return "smokePipe"
        case .loveComfort: return "love Comfort"
        case .loveAdventure: return " love Adventure"
        }
    }
}
