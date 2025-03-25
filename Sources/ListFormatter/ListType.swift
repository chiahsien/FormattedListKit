//
//  ListType.swift
//  FormattedListKit
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
}

/// Represents the type of list, either ordered or unordered, with its associated style.
public enum ListType: Hashable {
    case ordered(style: OrderedListStyle)
    case unordered(style: UnorderedListStyle)
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

/// Defines alignment options for list markers.
public enum MarkerAlignment: Hashable, CustomStringConvertible {
    case left
    case right

    public var description: String {
        switch self {
        case .left: return "Left"
        case .right: return "Right"
        }
    }
}
