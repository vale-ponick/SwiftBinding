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
    var state: DoorState = .closed
    var hasMark: Bool
    
    init(hasMark: Bool) {
        self.hasMark = hasMark
    }
    
    func openQuietly() {
        state = .openQuietly
    }
    
    func swingOpen() {
        state = .swungOpen
    }
    
    func eraseMark() {
        hasMark = false
    }
}

class DwarvenGuest: UnexpectedGuest {
    let name: DwarvesName
    let hood: HoodColor
    
    var isInside: Bool = false
    var didFall: Bool = false
    
    init(name: DwarvesName, hood: HoodColor) {
        self.name = name
        self.hood = hood
    }
    
    func enter(_ door: Door) {
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
    
    // Первые гномы — дверь открывается тихо
    let balin = DwarvenGuest(name: .balin, hood: .scarlet)
    let dwalin = DwarvenGuest(name: .dwalin, hood: .darkGreen)
    
    balin.enter(door)          // closed
    dwalin.enter(door)         // closed
    
    door.openQuietly()
    
    balin.enter(door)          // openQuietly
    dwalin.enter(door)         // openQuietly
    
    // Последние — Бильбо резко распахивает
    door.swingOpen()
    
    let thorin = DwarvenGuest(name: .thorin, hood: .skyBlue)
    thorin.enter(door)         // swungOpen — падает
    
    // Развязка
    print("\n🧙‍♂️ Gandalf laughs, removes the mark...")
    door.eraseMark()
    print("🍃 Bilbo apologizes.")
    print("🍽️ Everyone proceeds to the dining room. The company is assembled!")
}
/**
🚪 Thorin Company Gathered — Middle

🚪 Balin looks at the closed door and sees Gandalf's sign.
🚪 Dwalin looks at the closed door and sees Gandalf's sign.
🍃 Balin steps inside quietly, bows, and takes off the scarlet hood.
🍃 Dwalin steps inside quietly, bows, and takes off the dark green hood.
💥 The door yanks open! Thorin Oakenshield loses balance and tumbles into the hallway in a heap!

🧙‍♂️ Gandalf laughs, removes the mark...
🍃 Bilbo apologizes.
🍽️ Everyone proceeds to the dining room. The company is assembled!
*/
