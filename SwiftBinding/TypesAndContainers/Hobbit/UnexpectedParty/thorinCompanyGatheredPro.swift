//
// thorinCompanyGatheredPro.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 08.10.2026.
//

import Foundation

// MARK: - Thorin Company Gathered — Pro

// MARK: - 🎬 Plot
/** Plot:
 Gandalf secretly marks Bilbo's door with a glowing mark. That evening, the dwarves approach the closed door. Bilbo opens it in different ways:
 — quietly: the dwarves enter in pairs, greet each other, and proceed to the dining room.
 — rushing: the last four fall in a heap, angry.
 Gandalf laughs and removes the mark. Bilbo apologizes. Everyone is in the dining room — the company is assembled. */

// MARK: - 🛠️ Tools & Syntactic Bonds
/*
 1️⃣ Типы и контейнеры:
   • class — ссылочные типы
   • init — конструктор
   • typealias — псевдоним
   • static func — фабрика

 2️⃣ Безопасность данных:
   • guard — линия обороны

 3️⃣ Логика и ветвление:
   • enum + switch
   • where в for

 4️⃣ Коллекции:
   • .map + CaseIterable

 5️⃣ Структурирование:
   • extension

 6️⃣ Ошибки:
   • throws / throw
   • do-catch
 */

// MARK: - ⚙️ Инженерные решения
/*
 — Ссылочные типы (Reference Types):
   DwarvenGuestPro и DoorPro — классы, состояние меняется без копирования.

 — Ручная инициализация (Manual Initialization):
   Явный init + private(set) для безопасного изменения состояния.

 — Изоляция логики (Decoupled Extensions):
   summary вынесен в extension. Класс — хранилище данных.

 — Управление состояниями (Enum States):
   DoorStatePro вместо Bool. Каскадные триггеры через switch-case.

 — Функциональная коллекция (Functional Collection):
   .map + CaseIterable вместо ручного перечисления 13 объектов.

 — Валидация (Validation):
   guard + throw для проверки метки и количества гномов.

 — Кастомные ошибки (Custom Errors):
   enum GatheringErrorPro — разные ошибки, разная реакция.

 — Фабрика отряда (Factory):
   static func makeThorinCompany() — единая точка создания.
 */

// MARK: - Data

protocol UnexpectedGuestsPro {
    var summary: String { get }
}

typealias ThorinCompanyPro = [DwarvenGuestPro]

enum DoorStatePro {
    case doorClosed, doorOpenSlowly, doorThrownOpen
}

class DoorPro {
    private(set) var state: DoorStatePro = .doorClosed
    private(set) var hasMark: Bool
    
    init(hasMark: Bool) {
        self.hasMark = hasMark
    }
    
    func openSlowly() { state = .doorOpenSlowly }
    func throwOpen() { state = .doorThrownOpen }
    func eraseMark() { hasMark = false }
}

class DwarvenGuestPro: UnexpectedGuestsPro {
    let name: DwarvesName
    let hood: HoodColor
    
    private(set) var isInside: Bool = false
    private(set) var didFall: Bool = false
    
    init(name: DwarvesName, hood: HoodColor) {
        self.name = name
        self.hood = hood
    }
    
    func approach(_ door: DoorPro) {
        switch door.state {
        case .doorClosed:
            print("🚪 \(name.rawValue) looks at the closed door and sees Gandalf's sign.")
        case .doorOpenSlowly:
            isInside = true
            print("🍃 \(name.rawValue) steps inside quietly, bows, and takes off the \(hood.rawValue) hood.")
        case .doorThrownOpen:
            isInside = true
            didFall = true
            print("💥 The door yanks open! \(name.rawValue) loses balance and tumbles into the hallway in a heap!")
        }
    }
    
    static func makeThorinCompany() -> ThorinCompanyPro {
        DwarvesName.allCases.map {
            DwarvenGuestPro(name: $0, hood: HoodColor(for: $0))
        }
    }
}

extension DwarvenGuestPro {
    var summary: String {
        "\(name.rawValue) - \(hood.rawValue)"
    }
}

// MARK: - Errors & Validation

enum GatheringErrorPro: Error {
    case doorHasNotMark
    case wrongDwarfCount(expected: Int, actual: Int)
}

func validatePro(company: ThorinCompanyPro, door: DoorPro) throws {
    guard door.hasMark else {
        throw GatheringErrorPro.doorHasNotMark
    }
    guard company.count == 13 else {
        throw GatheringErrorPro.wrongDwarfCount(expected: 13, actual: company.count)
    }
}

// MARK: - Run

func runThorinCompanyGatheredPro() {
    print("🚪 Thorin Company Gathered — Pro\n")
    
    let door = DoorPro(hasMark: true)
    let company = DwarvenGuestPro.makeThorinCompany()
    
    do {
        try validatePro(company: company, door: door)
        
        door.openSlowly()
        for dwarf in company.prefix(9) {
            dwarf.approach(door)
        }
        
        door.throwOpen()
        for dwarf in company.suffix(4) {
            dwarf.approach(door)
        }
        
        print("\n🧙‍♂️ Gandalf laughs, removes the mark...")
        door.eraseMark()
        print("🍃 Bilbo apologizes.")
        print("🍽️ \(company.count) dwarves in the dining room. The company is assembled!")
        
        print("\n📜 Dining Room Guest List:")
        for dwarf in company where dwarf.isInside {
            print(dwarf.summary)
        }
        
    } catch GatheringErrorPro.doorHasNotMark {
        print("🚪 No mark on the door — dwarves pass by. The quest never starts.")
    } catch GatheringErrorPro.wrongDwarfCount(let expected, let actual) {
        print("⚠️ Expected \(expected) dwarves, but got \(actual). The company is not assembled.")
    } catch {
        print("❌ Unexpected error: \(error)")
    }
}

/**
 🚪 Thorin Company Gathered — Pro

 🍃 Balin steps inside quietly, bows, and takes off the scarlet hood.
 🍃 Thorin Oakenshield steps inside quietly, bows, and takes off the sky-blue hood with a long silver tassel hood.
 🍃 Dwalin steps inside quietly, bows, and takes off the dark green hood.
 🍃 Fili steps inside quietly, bows, and takes off the yellow hood.
 🍃 Kili steps inside quietly, bows, and takes off the yellow hood.
 🍃 Bofur steps inside quietly, bows, and takes off the brown hood.
 🍃 Bifur steps inside quietly, bows, and takes off the brown hood.
 🍃 Bombur steps inside quietly, bows, and takes off the brown hood.
 🍃 Nori steps inside quietly, bows, and takes off the purple hood.
 💥 The door yanks open! Ori loses balance and tumbles into the hallway in a heap!
 💥 The door yanks open! Dori loses balance and tumbles into the hallway in a heap!
 💥 The door yanks open! Oin loses balance and tumbles into the hallway in a heap!
 💥 The door yanks open! Gloin loses balance and tumbles into the hallway in a heap!

 🧙‍♂️ Gandalf laughs, removes the mark...
 🍃 Bilbo apologizes.
 🍽️ 13 dwarves in the dining room. The company is assembled!

 📜 Dining Room Guest List:
 Balin - scarlet
 Thorin Oakenshield - sky-blue hood with a long silver tassel
 Dwalin - dark green
 Fili - yellow
 Kili - yellow
 Bofur - brown
 Bifur - brown
 Bombur - brown
 Nori - purple
 Ori - brown
 Dori - purple
 Oin - brown
 Gloin - brown
 Program ended with exit code: 0
  */
