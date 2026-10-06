//
//  dwarvesOnTheDoorstep.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 06.10.2026.
//

import Foundation

// MARK: - 🎬 Plot
/** Gandalf secretly marked Bilbo Baggins's door with a glowing sign. The dwarves search for the right hole. If the sign is on the door, they open it and hang their hoods in the hallway. If the door is clean, they pass on by.*/
 
 // MARK: - 🛠️ Tools & Syntactic Bonds
/**
 — protocol + class + typealias
 — enum + computed + switch + struct
 — if-else + for-in
*/

// MARK: - ⚙️ Инженерная суть
/*
 — **Абстракция доменной модели (Value Types)**:
   Проектирование сущности `ArrivingDwarf` как легковесного типа значения (`struct`), инкапсулирующего строго типизированные свойства `DwarfName` и `HoodColor` для исключения уязвимостей, связанных с сырыми строковыми литералами (Zero-Hardcode).
 
 — **Управление памятью и ссылочные контейнеры (Reference Types)**:
   Применение ключевого слова `class` для моделирования отряда как ссылочного контейнера. Это подготавливает архитектуру к разделению общего состояния (Shared State) между участниками и закладывает основу для механизмов наследования.
 
 — **Инкапсуляция сигнатур типов (Type Aliasing)**:
   Использование псевдонима типа `typealias` для создания семантического слоя над коллекциями, абстрагирования инфраструктурного кода и обеспечения единой точки рефакторинга контейнеров данных.
 
 — **Детерминированное ветвление потока управления**:
   Реализация предикативной логики на основе булевых флагов (`Bool`) для безопасной маршрутизации и валидации состояний системы (Edge Cases) без создания побочных эффектов (Side Effects).
 */

protocol Guest {
    var summary: String { get } // вычисляемое свойство - геттер
}

enum DwarvesName: String {
    case balin = "Balin"
    case thorin = "Thorin Oakenshield"
    case dwalin = "Dwalin"
    case fili = "Fili"
    case kili = "Kili"
    case bofur = "Bofur"
    case bifur = "Bifur"
    case bombur = "Bombur"
    case nori = "Nori"
    case ori = "Ori"
    case dori = "Dori"
    case oin = "Oin"
    case gloin = "Gloin"
}
 
enum HoodColor: String {
    case skyBlue = "sky-blue hood with a long silver tassel"
    case darkGreen = "dark green"
    case scarlet = "scarlet"
    case yellow = "yellow"
    case purple = "purple"
    case grey = "grey"
    case white = "white"
    case brown = "brown"
    case paleGreen = "pale green"
    
    init(for dwarf: DwarvesName) {
          switch dwarf {
          case .dwalin: self = .darkGreen
          case .balin: self = .scarlet
          case .fili, .kili: self = .yellow
          case .thorin: self = .skyBlue
          case .dori, .nori: self = .purple
    
          default: self = .brown // Все остальные пока в коричневых капюшонах
          }
      }
}

struct Dwarf: Guest {
    let name: DwarvesName
    let hood: HoodColor
    
    var summary: String {
        " \(name.rawValue) - \(hood.rawValue)"
    }
}

func checkDoorSign(for dwarf: Dwarf, hasSign: Bool) -> String {
    if hasSign {
        return "\(dwarf.summary) saw the glowing sign, knocked, and entered the hole!"
    } else {
        return "\(dwarf.summary) saw a clean door and passed on by..."
    }
}
