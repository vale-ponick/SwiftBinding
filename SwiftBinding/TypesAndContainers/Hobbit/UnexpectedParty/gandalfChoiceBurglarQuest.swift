//
//  пandalfChoiceBurglarQuest.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 04.10.2026.
//

import Foundation

// MARK: - 'Gandalf's Choice: Burglar's Quest'
// TS: 🎬 Plot
/** Gandalf stands at Bilbo Baggins's hole. He needs a 14th member of Thorin's company—one who is stealthy, brave, and ready for adventure. The venerable hobbit looks like a typical homebody, but Gandalf is an experienced mentor; he must scan Bilbo's array of qualities and render an automated engineering verdict.*/

// объединим СВЯЗКУ 1️⃣ (Типы + computed properties) + 3️⃣ (Логика и switch + where) + 4️⃣ (Коллекции и трансформация: .map, .joined(separator:) и предикат .contains.).
// MARK: - ⚙️ Инженерная суть задачи:
/** Избавиться от хардкода строк в структурах. Перенести всю текстовую логику внутрь перечислений (enum) через вычисляемые свойства. Научить систему автоматически трансформировать массив качеств персонажа в красивую строку с помощью функциональных методов коллекций, а затем выполнить логический скоринг (анализ) кандидата. */
