//
//  ListType.swift
//  ListFormatter
//
//  Created by Nelson on 2025/3/24.
//

import Foundation

/// Defines styles for ordered lists.
public enum OrderedListStyle: Hashable {
    case decimal
    case lowerRoman
    case upperRoman
    case lowerAlpha
    case upperAlpha
}

/// Defines styles for unordered lists.
public enum UnorderedListStyle: Hashable {
    case disc
    case circle
    case square
    case custom(String)

    // MARK: - Hashable Conformance
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .disc:
            hasher.combine("disc")
        case .circle:
            hasher.combine("circle")
        case .square:
            hasher.combine("square")
        case .custom(let symbol):
            hasher.combine("custom")
            hasher.combine(symbol)
        }
    }

    public static func ==(lhs: UnorderedListStyle, rhs: UnorderedListStyle) -> Bool {
        switch (lhs, rhs) {
        case (.disc, .disc), (.circle, .circle), (.square, .square):
            return true
        case (.custom(let lSymbol), .custom(let rSymbol)):
            return lSymbol == rSymbol
        default:
            return false
        }
    }
}

/// Represents the type of list, either ordered or unordered, with its associated style.
public enum ListType {
    case ordered(style: OrderedListStyle)
    case unordered(style: UnorderedListStyle)
}

// MARK: - Hashable Conformance
extension ListType: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .ordered(let style):
            hasher.combine("ordered")
            hasher.combine(style)
        case .unordered(let style):
            hasher.combine("unordered")
            hasher.combine(style)
        }
    }

    public static func ==(lhs: ListType, rhs: ListType) -> Bool {
        switch (lhs, rhs) {
        case (.ordered(let lStyle), .ordered(let rStyle)):
            return lStyle == rStyle
        case (.unordered(let lStyle), .unordered(let rStyle)):
            return lStyle == rStyle
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible Conformance
extension ListType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ordered(let style):
            switch style {
            case .decimal: return "Decimal"
            case .lowerRoman: return "Lower Roman"
            case .upperRoman: return "Upper Roman"
            case .lowerAlpha: return "Lower Alpha"
            case .upperAlpha: return "Upper Alpha"
            }
        case .unordered(let style):
            switch style {
            case .disc: return "Disc"
            case .circle: return "Circle"
            case .square: return "Square"
            case .custom(let symbol): return "Custom (\(symbol))"
            }
        }
    }
}
