//
// MARK: - Thorin Company Gathered — Middle

// MARK: - 🎬 Plot
/** Plot:
 Gandalf secretly marks Bilbo's door with a glowing mark.
 That evening, the dwarves approach the closed door.
 Bilbo opens it in different ways:
 — quietly: the dwarves enter in pairs, greet each other, and proceed to the dining room.
 — rushing: the last four fall in a heap, angry.
 Gandalf laughs and removes the mark. Bilbo apologizes.
 Everyone is in the dining room — the company is assembled. */

// MARK: - 🛠️ Tools & Syntactic Bonds
/*
 — class (ссылочные типы для динамического изменения состояний)
 — init (обязательный конструктор в классах)
 — typealias (семантическая абстракция коллекций)
 — enum + switch (управление состояниями системы)
 — extension (изоляция логики форматирования)
 — .map + CaseIterable (компактное создание коллекции)
 — where в for (фильтрация)
 */

// MARK: - ⚙️ Инженерная суть
/*
 — Переход на ссылочные типы данных (Reference Types):
   DwarvenGuest и Door — экземпляры класса, состояние можно менять без копирования.

 — Контроль инкапсуляции и инициализации (Manual Initialization):
   Явный init для безопасного распределения свойств в момент создания.

 — Модульное разделение ответственности (Decoupled Extensions):
   Вынос summary в extension. Класс остаётся легковесным хранилищем данных.

 — Многовекторное управление потоком через полиморфные состояния:
   enum DoorState вместо Bool. Каскадные триггеры через switch-case.
 
 — Функциональное создание коллекции:
   .map + CaseIterable вместо ручного перечисления 13 объектов.
 */

// MARK: - Data

protocol UnexpectedGuest {
    var summary: String { get }
}

typealias ThorinCompany = [DwarvenGuest]

enum DoorState {
    case closed
    case openQuietly
    case swungOpen
}

class Door {
    private(set) var state: DoorState = .closed // инкапсуляции: «Чтение — всем, запись — только себе»
    private(set) var hasMark: Bool
    
    init(hasMark: Bool) {
        self.hasMark = hasMark
    }
    
    func openQuietly() { state = .openQuietly }
    func swingOpen() { state = .swungOpen }
    func eraseMark() { hasMark = false }
}

class DwarvenGuest: UnexpectedGuest {
    let name: DwarvesName
    let hood: HoodColor
    
    private(set) var isInside: Bool = false
    private(set) var didFall: Bool = false
    
    init(name: DwarvesName, hood: HoodColor) {
        self.name = name
        self.hood = hood
    }
    
    func approach(_ door: Door) {
        switch door.state {
        case .closed:
            print("🚪 \(name.rawValue) looks at the closed door and sees Gandalf's sign.")
        case .openQuietly:
            isInside = true
            print("🍃 \(name.rawValue) steps inside quietly, bows, and takes off the \(hood.rawValue) hood.")
        case .swungOpen:
            isInside = true
            didFall = true
            print("💥 The door yanks open! \(name.rawValue) loses balance and tumbles into the hallway in a heap!")
        }
    }
}

extension DwarvenGuest {
    var summary: String {
        "\(name.rawValue) - \(hood.rawValue)"
    }
}

// MARK: - Run

func runThorinCompanyGathered() {
    print("🚪 Thorin Company Gathered — Middle\n")
    
    let door = Door(hasMark: true)
    
    let company: ThorinCompany = DwarvesName.allCases.map {
        DwarvenGuest(name: $0, hood: HoodColor(for: $0))
    }
    
    door.openQuietly() // Первые 9 — дверь тихо открывается
    for dwarf in company.prefix(9) {
           dwarf.approach(door)
       }
    
    door.swingOpen() // Последние 4 — Бильбо резко распахивает
    for dwarf in company.suffix(4) {
        dwarf.approach(door)
    }
    
    // Развязка
    print("\n🧙‍♂️ Gandalf laughs, removes the mark...")
    door.eraseMark()
    print("🍃 Bilbo apologizes.")
    print("🍽️ \(company.count) dwarves in the dining room. The company is assembled!")
    
    print("\n📜 Dining Room Guest List:")
    for dwarf in company where dwarf.isInside {
        print(dwarf.summary)
    }
}
/**
 🚪 Thorin Company Gathered — Middle

 🍃 Dwalin steps inside quietly, bows, and takes off the dark green hood.
 🍃 Balin steps inside quietly, bows, and takes off the scarlet hood.
 🍃 Fili steps inside quietly, bows, and takes off the yellow hood.
 🍃 Kili steps inside quietly, bows, and takes off the yellow hood.
 🍃 Dori steps inside quietly, bows, and takes off the purple hood.
 🍃 Nori steps inside quietly, bows, and takes off the purple hood.
 🍃 Ori steps inside quietly, bows, and takes off the grey hood.
 🍃 Oin steps inside quietly, bows, and takes off the brown hood.
 🍃 Gloin steps inside quietly, bows, and takes off the brown hood.
 💥 The door yanks open! Bifur loses balance and tumbles into the hallway in a heap!
 💥 The door yanks open! Bofur loses balance and tumbles into the hallway in a heap!
 💥 The door yanks open! Bombur loses balance and tumbles into the hallway in a heap!
 💥 The door yanks open! Thorin Oakenshield loses balance and tumbles into the hallway in a heap!

 🧙‍♂️ Gandalf laughs, removes the mark...
 🍃 Bilbo apologizes.
 🍽️ 13 dwarves in the dining room. The company is assembled!

 📜 Dining Room Guest List:
 Dwalin - dark green
 Balin - scarlet
 Fili - yellow
 Kili - yellow
 Dori - purple
 Nori - purple
 Ori - grey
 Oin - brown
 Gloin - brown
 Bifur - brown
 Bofur - brown
 Bombur - brown
 Thorin Oakenshield - sky-blue hood with a long silver tassel
*/
