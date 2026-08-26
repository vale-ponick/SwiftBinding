//
//  main.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 26.08.2026.
//

import Foundation

// MARK: - 📋 О ПРОЕКТЕ

print("📋 Swift Patterns Dictionary: A dictionary app for interactive learning, revision, and quick reference of engineering patterns and Swift language bindings.")
print("🖖 Авторы: vale.ponick 🚕💨, DeepSeek AI Spock 🖖, Google AI, bro 🧠")
print("📌 Принцип: «Не просто учи тему — сразу проектируй инструмент, который поможет её применять.»")
print("")

// MARK: - 🏷️ КАТЕГОРИИ СВЯЗОК

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
        enum → struct → computed property → protocol → extension → запуск

        🔹 Что происходит на каждом шаге:

        🧩 ШАГ 1: enum — фиксированные варианты (value-type)
        → Задаёт список возможных состояний (тип валюты).

        🧩 ШАГ 2: struct — модель данных (value-type)
        → Хранит баланс и тип валюты.

        🧩 ШАГ 3: вычисляемое свойство
        → Форматирует баланс в зависимости от типа валюты.

        🧩 ШАГ 4: protocol — контракт
        → Определяет, что должен уметь объект (баланс и метод withdraw).

        🧩 ШАГ 5: extension — реализация контракта (mutating)
        → Добавляет метод withdraw с проверками и изменением баланса.

        🧩 ШАГ 6: запуск — создание объекта и вызов метода
        → Проверяем, как работает связка в реальном коде.
        """,
        // Используем #""# для сырого текста, чтобы Swift не ругался на \(balance) внутри строк
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

            // 3️⃣ ШАГ 3: вычисляемое свойство
            var formattedBalance: String {
                switch type {
                case .usd: return "$\(balance)"
                case .euro: return "€\(balance)"
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

        // 6️⃣ ШАГ 6: запуск
        var account = BankAccount(balance: 100.0, type: .usd)
        account.withdraw(amount: 30.0)
        // → ✅ Списано 30.0. Баланс: $70.0
        """#,
        components: [
            Component(name: "enum", syntax: "enum Name { case one, two }", example: "enum CurrencyType { case usd, euro }"),
            Component(name: "struct", syntax: "struct Name { let id: Int }", example: "struct BankAccount { var balance: Double }"),
            Component(name: "protocol", syntax: "protocol Name { func method() }", example: "protocol Chargeable { var balance: Double { get } }")
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

showBinding(for: "1")
