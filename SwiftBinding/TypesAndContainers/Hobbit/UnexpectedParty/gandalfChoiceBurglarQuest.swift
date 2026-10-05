//
//  gandalfChoiceBurglarQuest.swift
//  SwiftBinding
// The Hobbit — Unexpected Party

//  Created by Валерия Пономарева on 04.10.2026.
//

import Foundation

// MARK: - 'Gandalf's Choice: Burglar's Quest' - Simple

/** TS: Gandalf stands at Bilbo Baggins's hole. He needs a 14th member of Thorin's company—one who is stealthy, brave, and ready for adventure. The venerable hobbit looks like a typical homebody, but Gandalf is an experienced wizard; he must scan Bilbo's array of qualities and render an automated engineering verdict.
 
 Tools: enum + computed, switch + where, .map, .joined(separator:), .contains
 */

// объединим СВЯЗКУ 1️⃣ (Типы + computed properties) + 3️⃣ (Логика и switch + where) + 4️⃣ (Коллекции и трансформация: .map, .joined(separator:) и предикат .contains.).

// MARK: - ⚙️ Инженерная суть задачи:
/**
    — Избавиться от хардкода строк в структурах
    — Перенести текстовую логику в enum через computed
    — Трансформировать массив qualities в строку через .map + .joined
    — Выполнить логический скоринг кандидата */

protocol IdentityDescribable {
    var summary: String { get }
}

enum Species {
    case hobbit, wizard, dwarf
    
    var displaySpecies: String {
        switch self {
        case .hobbit: return "Small, comfort-loving folk with an iron core. Survivors of the Fell Winter, famine, and white wolf invasions, they possess unbelievable stamina. Famously deadly throwers—if a hobbit stoops for a stone, trespassing beasts run for cover."
        case .wizard: return "Mysterious, ancient wanderers and keepers of secret knowledge. They are protectors of the weak who helped the Shire survive the dark years of frost and famine. Masters of fire, light, fireworks, and subtle, commanding strategy."
        case .dwarf: return "Proud, stubborn, and unflinching mountain-dwellers bound by ancient heritage. Hardened by the loss of their kingdoms, they possess extreme physical power, immense greed for gold, and absolute resistance to freezing mountain blizzards."
        }
    }
}

enum Person {
    case Bilbo, Gandalf, Thorin, Balin, Fily, Kily
    
    var displayChar: String {
        switch self {
        case .Bilbo: return "Bilbo Baggins"
        case .Gandalf: return "Gandalf or Grey Wanderer"
        case .Thorin: return "he rightful Thorin Oakenshield, King under the Mountain in exile. A proud, fierce, and stubborn leader of the House of Durin, obsessed with reclaiming his stolen kingdom and ancient gold from the dragon Smaug."
        case .Balin: return "Balin, the elder watchman of the company with keen eyesight and a sharp mind. Wise, warm-hearted, and gentle, he becomes Bilbo's closest friend and mentor among the dwarves, always ready to guide, protect, and offer council."
        case .Fily: return "Fily, the youngest dwarven brothers and Thorin's loyal nephews. Full of youthful energy, exuberance, and sharp observation skills, they serve as the company's main scouts. Uncorrupted by greed, they are fiercely protective of the"
        case .Kily: return "Kily, the youngest dwarven brothers and Thorin's loyal nephews. Full of youthful energy, exuberance, and sharp observation skills, they serve as the company's main scouts. Uncorrupted by greed, they are fiercely protective of the"
        }
    }
}

enum QualityMember {
    // характер
    case brave
    case wise
    case cunning
    case greedy
    // склонности
    case loveAdventure
    case loveComfort
    case musical
    case hospitable
    case enduring
    // привычки
    case pipeSmoker
    // статус
    case respectable
    case decent
    case venerable
    
    var descriptionText: String {
          switch self {
          case .wise: return "is wise"
          case .cunning: return "is cunning"
          case .greedy: return "is greedy"
          case .brave: return "is brave"
          case .loveAdventure: return "love Adventure"
          case .loveComfort: return "loves comfort"
          case .musical: return "is musical"
          case .hospitable: return "is hospital"
          case .enduring: return "is enduring"
          case .pipeSmoker: return "smokes a pipe"
          case .respectable: return "is respectable"
          case .decent: return "is decent"
          case .venerable: return "is venerable"
          }
      }
}

struct CompanyMember: IdentityDescribable {
    let name: Person
    let age: Int?
    let species: Species
    let appearance: String?
    let qualities: [QualityMember]
    
    var summary: String {
        var result = "\(name.displayChar) - \(species)"
        if let age {
            result += ", \(age) year old."
        }
        return result
    }
    var fullDescription: String {
        var result = summary
        if let appearance {
            result += ", \(appearance)"
        }
        result += "\nTraits: " + qualities.map { $0.descriptionText }.joined(separator: ", ")
        
        return result
    }
}
func analyzeCandidate(_ character: CompanyMember) -> String {
    if character.species == .hobbit && (character.qualities.contains(.brave) || character.qualities.contains(.loveAdventure)) {
        return "Gandalf drew a burglar's mark on Bilbo Baggins' door"
    } else {
        return "Gandalf shakes his head and leaves empty-handed."
    }
}

func runBurglarQuest() {
    let bilbo = CompanyMember(name: .Bilbo, age: 50, species: .hobbit, appearance: "short, well-fed, curly hair, bare feet", qualities: [.brave, .hospitable, .loveComfort, .pipeSmoker, .respectable, .decent, .venerable])
    
    print(bilbo.fullDescription)
    print(analyzeCandidate(.init(name: .Bilbo, age: 50, species: .hobbit, appearance: "short, well-fed, curly hair, bare feet", qualities: [.brave, .hospitable, .loveComfort, .pipeSmoker, .respectable, .decent, .venerable])))
}
/**
 Bilbo Baggins - hobbit, 50 year old., short, well-fed, curly hair, bare feet
 Traits: is brave, is hospital, loves comfort, smokes a pipe, is respectable, is decent, is venerable
 Gandalf drew a burglar's mark on Bilbo Baggins' door
 */
