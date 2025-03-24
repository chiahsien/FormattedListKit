//
//  ListType.swift
//  ListFormatter
//
//  Created by Nelson on 2025/3/24.
//

import Foundation

/// Defines styles for ordered lists.
public enum OrderedListStyle {
    case decimal
    case lowerRoman
    case upperRoman
    case lowerAlpha
    case upperAlpha
}

/// Defines styles for unordered lists.
public enum UnorderedListStyle {
    case disc
    case circle
    case square
    case custom(String)
}

/// Represents the type of list, either ordered or unordered, with its associated style.
public enum ListType {
    case ordered(style: OrderedListStyle)
    case unordered(style: UnorderedListStyle)
}
