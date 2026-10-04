//
//  bilboMeetsGandalfSimple.swift
//  SwiftBinding
//  The Hobbit — Unexpected Party
//
//  Created by Валерия Пономарева on 04.10.2026.
//

import Foundation

// MARK: - Bilbo Meets Gandalf — Simple

/**
 TS: Gandalf comes to Bilbo. They smoke pipes and chat.
 Gandalf is looking for a 14th member for Thorin and Company.
 Bilbo declines, but invites him to tea.

 Tools: enum, struct, protocol, computed property, for, print
 */

// MARK: - ⚙️ Инженерная суть

/**
 — Модель персонажа через struct + enum
 — Краткая сводка через computed summary
 — Диалог через массив [Line] + цикл for
 — Два персонажа, один диалог — база
 */

protocol Describable {
    var summary: String { get }
}

enum Race {
    case hobbit, wizard, dwarf
}

enum Quality {
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
}
 
struct Character: Describable {
    let name: String
    let race: Race
    let age: Int?
    let appearance: String?
    let qualities: [Quality] // массив черт
    
    var summary: String {
        var result = "\(name) - \(race)"
        if let age {
            result += ", \(age) years"
        }
        return result
    }
    
    var fullDescription: String {
        var result = summary
        if let appearance {
            result += ". \(appearance)"
        }
        return result
    }
}

struct Line {
    let speaker: String
    let text: String
}

struct Conversation {
    let lines: [Line]
    
    var fullText: String {
        var result = ""
        for line in lines {
            result += "\(line.speaker): \(line.text)\n"
        }
        return result
    }
}

func runBilboMeetsGandalfSimple() {
    print("🚪 Bilbo Meets Gandalf — Simple")
    
    let bilbo = Character(
        name: "Bilbo Baggins",
        race: .hobbit,
        age: 50,
        appearance: "short, well-fed, curly hair, bare feet",
        qualities: [.loveComfort, .respectable, .decent, .venerable, .brave, .pipeSmoker]
    )
    
    let gandalf = Character(
        name: "Gandalf",
        race: .wizard,
        age: nil,
        appearance: "tall, long grey beard, pointed blue hat",
        qualities: [.wise, .cunning, .pipeSmoker]
    )
    
    print(bilbo.fullDescription)
    print(gandalf.fullDescription)
    
    let conversation = Conversation(lines: [
        Line(speaker: "🧙 Gandalf", text: "I am looking for someone to share in an adventure."),
        Line(speaker: "🍃 Bilbo", text: "No! But please come to tea — any time you like! Good-bye!")
    ])
    
    print(conversation.fullText)
}
/**
 🚪 Bilbo Meets Gandalf — Simple
 Bilbo Baggins - hobbit, 50 years. short, well-fed, curly hair, bare feet
 Gandalf - wizard. tall, long grey beard, pointed blue hat
 🧙 Gandalf: I am looking for someone to share in an adventure.
 🍃 Bilbo: No! But please come to tea — any time you like! Good-bye!
 */
