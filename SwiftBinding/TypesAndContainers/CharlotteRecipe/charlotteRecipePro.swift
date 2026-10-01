//
//  charlotteRecipePro.swift
//  SwiftBinding
//
//  Created by Валерия Пономарева on 01.10.2026.
//

import Foundation

// MARK: - 'CHARLOTTE RECIPE': level Pro

// TS: Validate the array of ingredients in the bowl. If Vale & Mama Lusia forgot to cut or add apples, added too much sugar, or messed up the proportions, the program should throw a hard custom exception (throw), which we'll safely handle at the top level in a do-catch block.

/**
 🧩 What concepts from our bindings are we practicing:
 1. Binding 6️⃣ ("Errors and Handling"): Creating an error matrix enum:Error, throws markers, the throw interrupt operator, and the do-catch safe zone.
 2. Binding 2️⃣ ("Data Security"): Using the guard operator to build a line of defense at function entry.
 3. Binding 4️⃣ ("Collections and Transformation"): The .first(where:) higher-order function for point-by-point search of the desired ingredient in an array without manual for loops.
 */
// MARK: - Data
