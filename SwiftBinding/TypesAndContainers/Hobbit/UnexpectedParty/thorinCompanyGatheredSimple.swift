//
//  thorinCompanyGatheredSimple.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 08.10.2026.
//

import Foundation

// MARK: -  'Thorin Company Gathered' - Simple

// MARK: - TS: Plot: Gandalf left a glowing magical mark on the door. The dwarves arrive individually or in groups. If the mark is visible, they knock, Bilbo opens the door, and they enter. An angry Bilbo, not expecting unexpected guests, abruptly throws the door open, four dwarves fall in the hallway, and Thorin becomes angry. Gandalf laughs, and the magical mark disappears. Bilbo apologizes, and the dwarves enter the living room: the whole company is assembled.

// Data

enum DoorStateSimple {
    case doorClosed, doorOpenedSmoothly, doorOpenSharply
}

// DRY (Don't Repeat Yourself)
struct DwarfSimple: UnexpectedGuest { // Единый контракт: Simple и Middle —> оба под UnexpectedGuest.
    let name: DwarvesName
    let hood: HoodColor
    
    var summary: String {
        "\(name.rawValue) - \(hood.rawValue)"
    }
    
    func react(to door: DoorStateSimple) -> String {
        switch door {
        case .doorClosed:
            return "\(name.rawValue) seen a magic sign on the closed door."
        case .doorOpenedSmoothly:
            return "The \(name.rawValue) enters and greets Bilbo, and takes off his \(hood.rawValue) hood."
        case .doorOpenSharply:
            return "Bilbo is angry... the \(name.rawValue) fall on top of each other."
        }
    }
}

func runThorinCompanyGatheredSimple(door: DoorStateSimple) {
    let balin = DwarfSimple(name: .balin, hood: .scarlet)
    let dwalin = DwarfSimple(name: .dwalin, hood: .darkGreen)
    let fili = DwarfSimple(name: .fili, hood: .yellow)
    let thorin = DwarfSimple(name: .thorin, hood: .skyBlue)
    
    let company = [balin, dwalin, fili, thorin]
    
    switch door {
    case .doorClosed:
        for dwarf in company {
            print(dwarf.react(to: door))
        }
    case .doorOpenedSmoothly:
        for dwarf in company {
            print(dwarf.react(to: door))
        }
    case .doorOpenSharply:
        for dwarf in company {
            print(dwarf.react(to: door))
        }
        print("\n🧙‍♂️ Gandalf laughs. The magic mark disappears.")
        print("🍃 Bilbo apologizes.")
        print("🍽️ \(company.count) dwarves in the dining room. The company is assembled!")
    }
}
/**
 Bilbo is angry... the Balin fall on top of each other.
 Bilbo is angry... the Dwalin fall on top of each other.
 Bilbo is angry... the Fili fall on top of each other.
 Bilbo is angry... the Thorin Oakenshield fall on top of each other.

 🧙‍♂️ Gandalf laughs. The magic mark disappears.
 🍃 Bilbo apologizes.
 🍽️ 4 dwarves in the dining room. The company is assembled!
 */
