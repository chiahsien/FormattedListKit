//
//  MarkerGenerator.swift
//  FormattedListKit
//
//  Created by Nelson on 2025/3/24.
//

import Foundation

internal struct MarkerGenerator {
    // Generates a string for a list marker based on the ordered list type and index
    static func marker(for style: OrderedListStyle, number: Int) -> String {
        switch style {
        case .decimal:
            return "\(number)."
        case .lowerRoman:
            return romanNumeral(for: number, isUpper: false) + "."
        case .upperRoman:
            return romanNumeral(for: number, isUpper: true) + "."
        case .lowerAlpha:
            return alphaNumeral(for: number, isUpper: false) + "."
        case .upperAlpha:
            return alphaNumeral(for: number, isUpper: true) + "."
        }
    }

    // Generates a string for a list marker based on the unordered list type
    static func marker(for style: UnorderedListStyle) -> String {
        switch style {
        case .disc:
            return "•"
        case .circle:
            return "◦"
        case .square:
            return "▪"
        case .custom(let symbol):
            return symbol.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    // Converts an integer to a Roman numeral string
    static func romanNumeral(for number: Int, isUpper: Bool) -> String {
        let romanValues = [
            (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
            (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
            (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
        ]
        var result = ""
        var num = number
        for (value, symbol) in romanValues {
            while num >= value {
                result += symbol
                num -= value
            }
        }
        return isUpper ? result : result.lowercased()
    }

    // Converts an integer to an alphabetic string (e.g., "a", "b", "aa")
    static func alphaNumeral(for number: Int, isUpper: Bool) -> String {
        var num = number
        var result = ""
        while num > 0 {
            num -= 1
            let char = String(UnicodeScalar((num % 26) + 97)!)
            result = char + result
            num /= 26
        }
        return isUpper ? result.uppercased() : result
    }
}
