//
//  GandalfCompanyTpl.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 09.10.2026.
//

import Foundation

// МИНИ-ШАБЛОН: все связки 1️⃣–9️⃣ в одном файле
// MARK: - 'Gandalf Company Template' - суффикс tpl, чтобы не было конфликта имен
// Сюжет: Гэндальф собирает отряд. 13 гномов — несчастливое число. Нужен 14-й — Бильбо-взломщик.


// 1️⃣ ТИПЫ И КОНТЕЙНЕРЫ

// protocol — «контракт»: что обязан уметь ТИП, который его подписывает.
// ПРОТОКОЛ ничего НЕ делает — only ОПИСЫВАЕТ требования.
protocol DescribableTpl {
    var summary: String { get }   // { get } — only чтение, без записи
}

// enum — фиксированный список вариантов.
// ": String" —> у каждого case auto есть строковое значение - rawValue. Example: RaceTpl.hobbit.rawValue == "hobbit"
enum RaceTpl: String {
    case hobbit, dwarf, wizard
}

// 7️⃣ class — ССЫЛОЧНЫЙ тип (в отличие от struct: value type). Нужен здесь, потому что:
//   1) weak работает ТОЛЬКО с классами
//   2) Двусторонняя связь( bidirectional relationship) = Осведомленность + Прямое действие:  два объекта (гнома) знают о существовании друг друга + могут взаимодействовать напрямую в обе стороны
class DwarfTpl: DescribableTpl {
    
    let name: String
    let race: RaceTpl

    // weak — СЛАБАЯ ссылка на отряд.
    // Обычная (сильная) ссылка «держит» объект (гнома) в памяти.
    // Если бы и CompanyTpl (отряд) держал DwarfTpl (гнома), и DwarfTpl держал CompanyTpl
    // сильными ссылками — возник бы ЦИКЛ, и оба никогда не удалились бы (утечка памяти).
    // weak разрывает цикл: гном ЗНАЕТ отряд, но НЕ держит его.
    weak var company: CompanyTpl?

    init(name: String, race: RaceTpl) {
        self.name = name
        self.race = race
    }

    // computed property — значение НЕ хранится, а ВЫЧИСЛЯЕТСЯ каждый раз при чтении.
    // В отличие от let name (stored property) — хранится в памяти.
    var summary: String {
        "\(name) (\(race.rawValue))"
    }
}

// 7️⃣ + 5️⃣ + 8️⃣
// class CompanyTpl — отряд. Держит участников, лидера, знает Гэндальфа.
class CompanyTpl {
    // private(set) — ЧИТАТЬ можно всем, а менять — только ВНУТРИ класса.
    // Защита от случайной порчи массива извне  <- ИНКАПСУЛЯЦИЯ.
    private(set) var members: [DwarfTpl] = []

    // Сильная ссылка на лидера — отряд «держит» Торина.
    var leader: DwarfTpl?

    // weak — Гэндальф «держит» отряд, а отряд на Гэндальфа ссылается слабо.
    // Так цикл CompanyTpl ↔ WizardTpl разорван.
    weak var wizard: WizardTpl?

    // 8️⃣ closure — замыкание, это stored property (хранимое свойство) класса CompanyTpl.
    // Тип: (DwarfTpl) -> Void — принимает гнома, ничего не возвращает.
    // Знак "?" — замыкание может быть nil (не задано).
    var onNewMember: ((DwarfTpl) -> Void)?

    // init — конструктор. Пустой, т.к. все свойства уже имеют значения по умолчанию ([] и nil).
    init() {}

    // add — добавляет участника и налаживает ОБРАТНУЮ связь объекта с объектом: гнома с отрядом.
    // member.company = self — гном теперь знает свой отряд (через weak).
    // onNewMember?(member) — если замыкание задано, вызвать его.
    func add(_ member: DwarfTpl) {
        members.append(member)
        member.company = self
        onNewMember?(member)
    }

    // 2️⃣ ОПЦИОНАЛЫ
    // leader?.name — опциональная цепочка: если leader == nil, вернёт nil.
    // ?? "No leader" — nil-coalescing: если слева nil, взять правую строку.
    var leaderName: String {
        leader?.name ?? "No leader"
    }

    var isComplete: Bool {
        members.count == 14
    }
}

// 7️⃣ WizardTpl — Гэндальф.
// Здесь сильная ссылка на отряд: он его собрал, он его «держит».
class WizardTpl {
    let name: String
    var company: CompanyTpl?

    init(name: String) {
        self.name = name
    }
}

// 5️⃣ EXTENSION + 3️⃣ ЛОГИКА + 4️⃣ КОЛЛЕКЦИИ
// extension — добавляет методы/свойства к типу БЕЗ изменения самого типа.
// Компания объявлена выше — здесь мы её «достраиваем».
extension CompanyTpl {

    // 3️⃣ switch + where
    // switch — перебор вариантов enum + where — ДОПОЛНИТЕЛЬНОЕ условие на конкретный case.
    // Здесь: если раса hobbit И имя Bilbo — отдельный текст.
    func greet(_ member: DwarfTpl) -> String {
        switch member.race {
        case .hobbit where member.name == "Bilbo":
            return "🧙‍♂️ Gandalf: Hello, Bilbo - burglar!"
        case .hobbit:
            return "Hello, hobbit!"
        case .dwarf:
            return "Hello, dwarf!"
        case .wizard:
            return "Hello, wizard!"
        }
    }

    // 4️⃣ .map — превращает массив объектов в массив имён. [DwarfTpl] -> [String]
    var names: [String] {
        members.map { $0.name }
    }

    // 4️⃣ .filter — оставляет только тех, кто соответствует условию.
    var dwarvesOnly: [DwarfTpl] {
        members.filter { $0.race == .dwarf }
    }

    // 4️⃣ .contains = true, если есть ХОТЯ БЫ ОДИН подходящий элемент.
    var hasHobbit: Bool {
        members.contains { $0.race == .hobbit }
    }

    // 8️⃣ @escaping
    // Обычное замыкание живёт только внутри функции.
    // @escaping — «убегающее»: может быть вызвано ПОЗЖЕ, после выхода из функции, или сохранено. Здесь forEach вызывает action сразу, но помечаем @escaping — стандартный стиль для API, принимающих замыкания.
    func announce(_ action: @escaping (DwarfTpl) -> Void) {
        members.forEach { action($0) }
    }
}

// 6️⃣ ОШИБКИ
// enum, подписанный под Error — «матрица ошибок». associated values (actual:, expected:) — ошибка несёт данные.
enum CompanyErrorTpl: Error {
    case empty
    case unluckyNumber(actual: Int)
    case notComplete(expected: Int, actual: Int)
    case noLeader
}

// throws — функция МОЖЕТ выбросить ошибку. Вызывающий обязан обработать.
// guard — «линия обороны»: если условие ЛОЖНО, выйти из функции (throw/return).
// guard удобнее if в валидации: основная логика не уезжает вправо - нет 'пирамиды погибели'.
func validateTpl(_ company: CompanyTpl) throws {
    guard !company.members.isEmpty else {
        throw CompanyErrorTpl.empty
    }
    guard company.leader != nil else {
        throw CompanyErrorTpl.noLeader
    }
    guard company.members.count != 13 else {
        throw CompanyErrorTpl.unluckyNumber(actual: 13)
    }
    guard company.members.count == 14 else { // волшебные числа? хардкодим/нет?
        throw CompanyErrorTpl.notComplete(expected: 14, actual: company.members.count)
    }
}

// RUN — точка входа
func runTpl() {
    print("🧙 Mini-template: all bindings 1️⃣–9️⃣\n")

    // 7️⃣ ARC-связи
    let gandalf = WizardTpl(name: "Gandalf")
    let company = CompanyTpl()
    gandalf.company = company     // сильная: Гэндальф держит отряд
    company.wizard = gandalf      // weak: отряд слабо ссылается на Гэндальфа

    // 8️⃣ замыкание при добавлении
    company.onNewMember = { member in
        print("🆕 \(member.name) joined the company!")
    }

    let thorin = DwarfTpl(name: "Thorin Oakenshield", race: .dwarf)
    let balin = DwarfTpl(name: "Balin", race: .dwarf)
    let bilbo = DwarfTpl(name: "Bilbo Baggins", race: .hobbit)

    company.leader = thorin    // лидер назначен до валидации - см. guard company.leader != nil else { -> проверка отряда сразу завершиьтся ошибкой «Нет лидера», даже НЕ дойдя до подсчета гномов.

    // добавляем двух гномов + ещё 11 = 13 (несчастливое число)
    company.add(thorin)
    company.add(balin)
    for i in 1...11 {
        company.add(DwarfTpl(name: "Dwarf \(i)", race: .dwarf))
    }

    // 6️⃣ do-catch
    // try — вызов функции, которая может бросить ошибку. catch — обработка. Можно ловить КОНКРЕТНЫЕ случаи (разная реакция).
    do {
        try validateTpl(company)
        print("✅ Company complete!")
    } catch CompanyErrorTpl.empty {
        print("❌ Empty company")
    } catch CompanyErrorTpl.unluckyNumber(let actual) {
        print("❌ Unlucky number: \(actual)! The quest won't start. We need a burglar.")
    } catch CompanyErrorTpl.notComplete(let expected, let actual) {
        print("⚠️ Expected \(expected), got \(actual).")
    } catch CompanyErrorTpl.noLeader {
        print("❌ No leader")
    } catch { // последний catch — «на всё остальное», обязателен
        print("❌ Unexpected: \(error)")
    }

    print("\n--- Добавляем 14-го участника ---")
    company.add(bilbo)

    do {
        try validateTpl(company)
        print("✅ Success! Company is complete with 14 members. The quest begins!")
    } catch {
        print("❌ Validation failed: \(error)")
    }

    // 3️⃣ + 4️⃣ + 8️⃣
    print("\n📋 Members count: \(company.members.count)")
    print("👑 Leader: \(company.leaderName)")
    print("📦 Total dwarves: \(company.dwarvesOnly.count)")

    print("\n📣 Greet loop:")
    company.announce { member in
        print(company.greet(member))
    }
}

/**
 🧙 Mini-template: all bindings 1️⃣–9️⃣

 🆕 Thorin Oakenshield joined the company!
 🆕 Balin joined the company!
 🆕 Dwarf 1 joined the company!
 🆕 Dwarf 2 joined the company!
 🆕 Dwarf 3 joined the company!
 🆕 Dwarf 4 joined the company!
 🆕 Dwarf 5 joined the company!
 🆕 Dwarf 6 joined the company!
 🆕 Dwarf 7 joined the company!
 🆕 Dwarf 8 joined the company!
 🆕 Dwarf 9 joined the company!
 🆕 Dwarf 10 joined the company!
 🆕 Dwarf 11 joined the company!
 ❌ Unlucky number: 13! The quest won't start. We need a burglar.

 --- Добавляем 14-го участника ---
 🆕 Bilbo Baggins joined the company!
 ✅ Success! Company is complete with 14 members. The quest begins!

 📋 Members count: 14
 👑 Leader: Thorin Oakenshield
 📦 Total dwarves: 13

 📣 Greet loop:
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, dwarf!
 Hello, hobbit!
 Program ended with exit code: 0
 */
