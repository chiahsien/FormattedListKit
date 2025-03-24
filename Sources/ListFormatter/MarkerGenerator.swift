//
//  MarkerGenerator.swift
//  ListFormatter
//
//  Created by Nelson on 2025/3/24.
//

import UIKit

internal struct MarkerGenerator {
    // Generates an attributed string for a list marker based on the list type and index
    static func marker(for index: Int, type: ListType, font: UIFont) -> NSAttributedString {
        switch type {
        case .ordered(let style):
            switch style {
            case .decimal:
                return NSAttributedString(string: "\(index + 1).", attributes: [.font: font])
            case .lowerRoman:
                return NSAttributedString(string: romanNumeral(for: index + 1, isUpper: false) + ".", attributes: [.font: font])
            case .upperRoman:
                return NSAttributedString(string: romanNumeral(for: index + 1, isUpper: true) + ".", attributes: [.font: font])
            case .lowerAlpha:
                return NSAttributedString(string: alphaNumeral(for: index + 1, isUpper: false) + ".", attributes: [.font: font])
            case .upperAlpha:
                return NSAttributedString(string: alphaNumeral(for: index + 1, isUpper: true) + ".", attributes: [.font: font])
            }
        case .unordered(let style):
            switch style {
            case .disc:
                return NSAttributedString(string: "•", attributes: [.font: font])
            case .circle:
                return NSAttributedString(string: "◦", attributes: [.font: font])
            case .square:
                return NSAttributedString(string: "▪", attributes: [.font: font])
            case .custom(let symbol):
                return NSAttributedString(string: symbol.trimmingCharacters(in: .whitespaces), attributes: [.font: font])
            }
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
