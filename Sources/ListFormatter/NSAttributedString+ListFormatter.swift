//
//  NSAttributedString+ListFormatter.swift
//  ListFormatter
//
//  Created by Nelson on 2025/3/24.
//

import UIKit

extension NSAttributedString {
    /// Creates an attributed string formatted as a list with markers.
    ///
    /// This method generates a list from an array of strings, applying the specified list type and font.
    /// The list markers (e.g., numbers or bullets) are right-aligned, and the text is left-aligned with proper indentation for wrapped lines.
    ///
    /// - Parameters:
    ///   - items: An array of strings representing the list items.
    ///   - type: The type of list, either ordered (e.g., numbered) or unordered (e.g., bulleted).
    ///   - font: The font used for the list. Defaults to the system font with a size of 17 points.
    /// - Returns: An `NSAttributedString` representing the formatted list.
    public static func createList(for items: [String], type: ListType, font: UIFont = .systemFont(ofSize: 17)) -> NSAttributedString {
        // Calculate the maximum width of the markers
        let maxWidth: CGFloat
        switch type {
        case .ordered:
            var tempMaxWidth: CGFloat = 0
            for index in 0..<items.count {
                let marker = MarkerGenerator.marker(for: index, type: type, font: font)
                let width = marker.size().width
                if width > tempMaxWidth {
                    tempMaxWidth = width
                }
            }
            maxWidth = tempMaxWidth
        case .unordered:
            let marker = MarkerGenerator.marker(for: 0, type: type, font: font)
            maxWidth = marker.size().width
        }

        // Define spacing between marker and text
        let spacing: CGFloat = 4.0

        // Configure paragraph style for list formatting
        let tabStops = [
            NSTextTab(textAlignment: .right, location: maxWidth),
            NSTextTab(textAlignment: .left, location: maxWidth + spacing)
        ]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tabStops = tabStops
        paragraphStyle.defaultTabInterval = 0
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = maxWidth + spacing
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = .byWordWrapping

        // Create attributed strings for each list item
        var attributedStrings: [NSAttributedString] = []
        for (index, item) in items.enumerated() {
            let marker = MarkerGenerator.marker(for: index, type: type, font: font)
            let itemString = marker.string + "\t" + item
            let itemAttr = NSAttributedString(string: itemString, attributes: [
                .font: font,
                .paragraphStyle: paragraphStyle
            ])
            attributedStrings.append(itemAttr)
        }

        // Combine items with newline separators
        let combinedAttr = NSMutableAttributedString()
        for (index, attr) in attributedStrings.enumerated() {
            if index > 0 {
                combinedAttr.append(NSAttributedString(string: "\n"))
            }
            combinedAttr.append(attr)
        }

        return combinedAttr
    }
}
