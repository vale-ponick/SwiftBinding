//
//  descriptionTypesAndContainers.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 30.09.2026.
//

import Foundation

// MARK: - 📋 О ПРОЕКТЕ
/**
 SwiftBinding: An interactive data-driven dictionary app designed to master Swift syntax
 // by thinking in functional blocks and architectural patterns rather than raw lines of code.
 */
// MARK: - 🏷️ КАТЕГОРИИ СВЯЗОК
// 📦 BINDING 1️⃣: [Types and Containers] -> The foundational architectural block for data modeling.
// Core Chain: enum (states) → struct (models) → computed property (formatting) → protocol (contracts) → extension (implementation) → typealias (clean syntax).

enum BindingCategory {
    case typesAndContainers
    case dataSafety
    case logicAndBranching
    case codeStructuring
    case errorAndHandling
    case memoryManagement
    case dataFlow
    case cleanCode
}

// MARK: - 📦 КОМПОНЕНТ (отдельный термин)

struct Component {
    let name: String
    let syntax: String
    let example: String
}

// MARK: - 📘 СВЯЗКА (группа компонентов)

struct Binding {
    let id: String
    let title: String
    let goal: String
    let describing: String   // текстовое описание + шаги
    let snippet: String      // код, который можно скопировать и запустить
    let components: [Component]
    let category: BindingCategory
}

// MARK: - 🗂️ БАЗА ДАННЫХ (все связки)

let bindings: [String: Binding] = [

    // Используем простой ключ "1", чтобы Swift не путался в эмодзи
    "1": Binding(
         id: "1️⃣",
         title: "Типы и контейнеры",
         goal: "Создание моделей данных",
         describing: """
         📌 Связка 1️⃣: Типы и контейнеры

         🔹 Цель:
         Создание моделей данных через enum, struct и protocol.

         🔹 Порядок (архитектура):
         enum → struct → computed property → protocol → extension → typealias → запуск

         🔹 Что происходит на каждом шаге:

         🧩 ШАГ 1: enum — фиксированные варианты (value-type)
         → Задаёт список возможных состояний (тип валюты).

         🧩 ШАГ 2: struct — модель данных (value-type)
         → Хранит баланс и тип валюты.

         🧩 ШАГ 3: вычисляемое свойство (Computed Property)
         → Форматирует баланс в зависимости от типа валюты без явного return.

         🧩 ШАГ 4: protocol — контракт
         → Определяет, что должен уметь объект (баланс и метод withdraw).

         🧩 ШАГ 5: extension — реализация контракта (mutating)
         → Добавляет метод withdraw с проверками и изменением баланса для структур.
         
         🧩 ШАГ 6: typealias — псевдоним типов
         → Делает код более читаемым, заменяя сложные типы на простые имена.
         """,
         snippet: #"""
         // 🧪 ЖИВОЙ ПРИМЕР: 1️⃣ ТИПЫ И КОНТЕЙНЕРЫ

         // 1️⃣ ШАГ 1: enum — список состояний
         enum CurrencyType {
             case usd
             case euro
         }

         // 2️⃣ ШАГ 2: struct — модель данных
         struct BankAccount {
             var balance: Double
             let type: CurrencyType

             // 3️⃣ ШАГ 3: вычисляемое свойство (Swift Style: без return)
             var formattedBalance: String {
                 switch type {
                 case .usd: "$\(balance)"
                 case .euro: "€\(balance)"
                 }
             }
         }

         // 4️⃣ ШАГ 4: protocol — контракт
         protocol Chargeable {
             var balance: Double { get }
             func withdraw(amount: Double)
         }

         // 5️⃣ ШАГ 5: extension — реализация контракта
         extension BankAccount: Chargeable {
             mutating func withdraw(amount: Double) {
                 guard amount > 0, balance >= amount else {
                     print("❌ Ошибка: сумма некорректна или недостаточно средств")
                     return
                 }
                 balance -= amount
                 print("✅ Списано \(amount). Баланс: \(formattedBalance)")
             }
         }
         
         // 6️⃣ ШАГ 6: typealias — псевдоним для удобства
         typealias Dollars = BankAccount

         // 7️⃣ ШАГ 7: запуск
         var account = Dollars(balance: 100.0, type: .usd)
         account.withdraw(amount: 30.0) 
         // Выведет в консоль: ✅ Списано 30.0. Баланс: $70.0
         """#,
         components: [
             Component(name: "enum", syntax: "enum Name { case one, two }", example: "enum CurrencyType { case usd, euro }"),
             Component(name: "struct", syntax: "struct Name { let id: Int }", example: "struct BankAccount { var balance: Double }"),
             Component(name: "protocol", syntax: "protocol Name { func m() }", example: "protocol Chargeable { var balance: Double { get } }"),
             Component(name: "typealias", syntax: "typealias Name = ExistingType", example: "typealias Dollars = BankAccount"),
             Component(name: "associatedtype", syntax: "associatedtype Item", example: "Используется как дженерик внутри протоколов")
         ],
         category: .typesAndContainers
     )
]

// MARK: - 🔍 ФУНКЦИЯ ПОИСКА

func showBinding(for id: String) {
    guard let binding = bindings[id] else {
        print("❌ Связка \(id) не найдена")
        return
    }

    print("📦 \(binding.id) \(binding.title)")
    print("🎯 Цель: \(binding.goal)")
    print("📖 Описание:")
    print(binding.describing)
    print("\n🧩 Компоненты:")
    for component in binding.components {
        print("  • \(component.name) → \(component.syntax)  // \(component.example)")
    }
    print("\n💻 Пример кода (скопируй и запусти):")
    print(binding.snippet)
    print("")
}

// MARK: - 🚕💨 ЗАПУСК

/* showBinding(for: "1")
print("📋 Swift Patterns Dictionary: A dictionary app for interactive learning, revision, and quick reference of engineering patterns and Swift language bindings.")
print("🖖 Авторы: vale.ponick 🚕💨, DeepSeek AI Spock 🖖, Google AI, bro 🧠")
print("📌 Принцип: «Не просто учи тему — сразу проектируй инструмент, который поможет её применять.»")
print("") */

/**
 📦 1️⃣ Типы и контейнеры
 🎯 Цель: Создание моделей данных
 📖 Описание:
 📌 Связка 1️⃣: Типы и контейнеры

 🔹 Цель:
 Создание моделей данных через enum, struct и protocol.

 🔹 Порядок (архитектура):
 enum → struct → computed property → protocol → extension → typealias → запуск

 🔹 Что происходит на каждом шаге:

 🧩 ШАГ 1: enum — фиксированные варианты (value-type)
 → Задаёт список возможных состояний (тип валюты).

 🧩 ШАГ 2: struct — модель данных (value-type)
 → Хранит баланс и тип валюты.

 🧩 ШАГ 3: вычисляемое свойство (Computed Property)
 → Форматирует баланс в зависимости от типа валюты без явного return.

 🧩 ШАГ 4: protocol — контракт
 → Определяет, что должен уметь объект (баланс и метод withdraw).

 🧩 ШАГ 5: extension — реализация контракта (mutating)
 → Добавляет метод withdraw с проверками и изменением баланса для структур.

 🧩 ШАГ 6: typealias — псевдоним типов
 → Делает код более читаемым, заменяя сложные типы на простые имена.

 🧩 Компоненты:
   • enum → enum Name { case one, two }  // enum CurrencyType { case usd, euro }
   • struct → struct Name { let id: Int }  // struct BankAccount { var balance: Double }
   • protocol → protocol Name { func m() }  // protocol Chargeable { var balance: Double { get } }
   • typealias → typealias Name = ExistingType  // typealias Dollars = BankAccount
   • associatedtype → associatedtype Item  // Используется как дженерик внутри протоколов

 💻 Пример кода (скопируй и запусти):
 // 🧪 ЖИВОЙ ПРИМЕР: 1️⃣ ТИПЫ И КОНТЕЙНЕРЫ

 // 1️⃣ ШАГ 1: enum — список состояний
 enum CurrencyType {
     case usd
     case euro
 }

 // 2️⃣ ШАГ 2: struct — модель данных
 struct BankAccount {
     var balance: Double
     let type: CurrencyType

     // 3️⃣ ШАГ 3: вычисляемое свойство (Swift Style: без return)
     var formattedBalance: String {
         switch type {
         case .usd: "$\(balance)"
         case .euro: "€\(balance)"
         }
     }
 }

 // 4️⃣ ШАГ 4: protocol — контракт
 protocol Chargeable {
     var balance: Double { get }
     func withdraw(amount: Double)
 }

 // 5️⃣ ШАГ 5: extension — реализация контракта
 extension BankAccount: Chargeable {
     mutating func withdraw(amount: Double) {
         guard amount > 0, balance >= amount else {
             print("❌ Ошибка: сумма некорректна или недостаточно средств")
             return
         }
         balance -= amount
         print("✅ Списано \(amount). Баланс: \(formattedBalance)")
     }
 }

 // 6️⃣ ШАГ 6: typealias — псевдоним для удобства
 typealias Dollars = BankAccount

 // 7️⃣ ШАГ 7: запуск
 var account = Dollars(balance: 100.0, type: .usd)
 account.withdraw(amount: 30.0)
 // Выведет в консоль: ✅ Списано 30.0. Баланс: $70.0
 */
