//
//  gandalfChoiceBurglarQuest.swift
//  SwiftBinding
// The Hobbit — Unexpected Party

//  Created by Валерия Пономарева on 04.10.2026.
//

import Foundation

// MARK: - 'Gandalf's Choice: Burglar's Quest' - Simple

/** TS: Gandalf stands at Bilbo Baggins's hole. He needs a 14th member of Thorin's company—one who is stealthy, brave, and ready for adventure. The venerable hobbit looks like a typical homebody, but Gandalf is an experienced wizard; he must scan Bilbo's array of qualities and render an automated engineering verdict.
 
 Tools: enum + computed, switch + where, .map, .joined(separator:), .contains
 */

// объединим СВЯЗКУ 1️⃣ (Типы + computed properties) + 3️⃣ (Логика и switch + where) + 4️⃣ (Коллекции и трансформация: .map, .joined(separator:) и предикат .contains.).
// MARK: - ⚙️ Инженерная суть задачи:
/** // Инженерная суть:
 // — Избавиться от хардкода строк в структурах
 // — Перенести текстовую логику в enum через computed
 // — Трансформировать массив qualities в строку через .map + .joined
 // — Выполнить логический скоринг кандидата */
