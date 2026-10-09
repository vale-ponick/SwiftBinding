//
//  GandalfCompanyTpl.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 09.10.2026.
//

import Foundation

// МИНИ-ШАБЛОН: все связки 1️⃣–9️⃣ в одном файле
// Суффикс "Tpl" — чтобы не конфликтовать с другими сценами
// Сюжет: Гэндальф собирает отряд. 13 гномов — несчастливое число. Нужен 14-й — Бильбо-взломщик.


// 1️⃣ ТИПЫ И КОНТЕЙНЕРЫ

// protocol — «контракт»: что обязан уметь тип, который его подписывает.
// Сам по себе ничего не делает — только описывает требования.
protocol DescribableTpl {
    var summary: String { get }   // { get } — только чтение, без записи
}

// enum — фиксированный список вариантов.
// ": String" — значит у каждого case есть строковое значение (rawValue).
// Пример: RaceTpl.hobbit.rawValue == "hobbit"
enum RaceTpl: String {
    case hobbit, dwarf, wizard
}

// 7️⃣ class — ССЫЛОЧНЫЙ тип (в отличие от struct — ЗНАЧИМОГО).
// Нужен здесь, потому что:
//   1) weak работает ТОЛЬКО с классами
//   2) отряд и его члены должны ссылаться друг на друга
class CompanionTpl: DescribableTpl {
    let name: String
    let race: RaceTpl

    // weak — СЛАБАЯ ссылка на отряд.
    // Обычная (сильная) ссылка «держит» объект в памяти.
    // Если бы и CompanyTpl держал CompanionTpl, и CompanionTpl держал CompanyTpl
    // сильными ссылками — возник бы ЦИКЛ, и оба никогда не удалились бы (утечка).
    // weak разрывает цикл: гном знает отряд, но НЕ держит его.
    weak var company: CompanyTpl?

    init(name: String, race: RaceTpl) {
        self.name = name
        self.race = race
    }

    // computed property — значение НЕ хранится, а вычисляется каждый раз при чтении.
    // В отличие от let name (stored property — хранится в памяти).
    var summary: String {
        "\(name) (\(race.rawValue))"
    }
}

// 7️⃣ + 5️⃣ + 8️⃣
// class CompanyTpl — отряд. Держит участников, лидера, знает Гэндальфа.
class CompanyTpl {
    // private(set) — читать можно всем, а менять — только внутри класса.
    // Защита от случайной порчи массива извне (инкапсуляция).
    private(set) var members: [CompanionTpl] = []

    // Сильная ссылка на лидера — отряд «держит» Торина.
    var leader: CompanionTpl?

    // weak — Гэндальф «держит» отряд, а отряд на Гэндальфа ссылается слабо.
    // Так цикл CompanyTpl ↔ WizardTpl разорван.
    weak var wizard: WizardTpl?

    // 8️⃣ closure — замыкание, которое хранится в свойстве.
    // Тип: (CompanionTpl) -> Void — принимает гнома, ничего не возвращает.
    // Знак "?" — замыкание может быть nil (не задано).
    var onNewMember: ((CompanionTpl) -> Void)?

    // init — конструктор. Пустой, потому что все свойства уже имеют
    // значения по умолчанию ([] и nil).
    init() {}

    // add — добавляет участника и налаживает ОБРАТНУЮ связь.
    // member.company = self — гном теперь знает свой отряд (через weak).
    // onNewMember?(member) — если замыкание задано, вызвать его.
    func add(_ member: CompanionTpl) {
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
    // switch — перебор вариантов enum.
    // where — ДОПОЛНИТЕЛЬНОЕ условие на конкретный case.
    // Здесь: если раса hobbit И имя Bilbo — отдельный текст.
    func greet(_ member: CompanionTpl) -> String {
        switch member.race {
        case .hobbit where member.name == "Bilbo":
            return "🧙‍♂️ Gandalf: Hello, burglar!"
        case .hobbit:
            return "Hello, hobbit!"
        case .dwarf:
            return "Hello, dwarf!"
        case .wizard:
            return "Hello, wizard!"
        }
    }

    // 4️⃣ .map — превращает массив объектов в массив имён.
    // [CompanionTpl] -> [String]
    var names: [String] {
        members.map { $0.name }
    }

    // 4️⃣ .filter — оставляет только тех, кто проходит условие.
    var dwarvesOnly: [CompanionTpl] {
        members.filter { $0.race == .dwarf }
    }

    // 4️⃣ .contains — true, если есть ХОТЯ БЫ ОДИН подходящий элемент.
    var hasHobbit: Bool {
        members.contains { $0.race == .hobbit }
    }

    // 8️⃣ @escaping
    // Обычное замыкание живёт только внутри функции.
    // @escaping — «убегающее»: может быть вызвано ПОЗЖЕ, после выхода из функции,
    // или сохранено. Здесь forEach вызывает action сразу, но помечаем @escaping —
    // стандартный стиль для API, принимающих замыкания.
    func announce(_ action: @escaping (CompanionTpl) -> Void) {
        members.forEach { action($0) }
    }
}

// 6️⃣ ОШИБКИ
// enum, подписанный под Error — «матрица ошибок».
// associated values (actual:, expected:) — ошибка несёт данные.
enum CompanyErrorTpl: Error {
    case empty
    case unluckyNumber(actual: Int)
    case notComplete(expected: Int, actual: Int)
    case noLeader
}

// throws — функция МОЖЕТ выбросить ошибку. Вызывающий обязан обработать.
// guard — «линия обороны»: если условие ЛОЖНО, выйти из функции (throw/return).
// guard удобнее if в валидации: основная логика не уезжает вправо.
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
    guard company.members.count == 14 else {
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

    let thorin = CompanionTpl(name: "Thorin Oakenshield", race: .dwarf)
    let balin = CompanionTpl(name: "Balin", race: .dwarf)
    let bilbo = CompanionTpl(name: "Bilbo Baggins", race: .hobbit)

    company.leader = thorin    // лидер назначен до валидации

    // добавляем двух гномов + ещё 11 = 13 (несчастливое число)
    company.add(thorin)
    company.add(balin)
    for i in 1...11 {
        company.add(CompanionTpl(name: "Dwarf \(i)", race: .dwarf))
    }

    // 6️⃣ do-catch
    // try — вызов функции, которая может бросить ошибку.
    // catch — обработка. Можно ловить КОНКРЕТНЫЕ случаи (разная реакция).
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
    } catch {
        // последний catch — «на всё остальное», обязателен
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


