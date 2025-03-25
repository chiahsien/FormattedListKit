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
    /// The list markers (e.g., numbers or bullets) are aligned according to the specified marker alignment,
    /// and the text is left-aligned with proper indentation for wrapped lines.
    /// 
    /// - Parameters:
    ///   - items: An array of strings representing the list items.
    ///   - type: The type of list, either ordered (e.g., numbered) or unordered (e.g., bulleted).
    ///   - font: The font used for the list. Defaults to the system font with a size of 17 points.
    ///   - markerAlignment: The alignment of the list markers. Defaults to `.right`.
    ///   - spacing: The spacing between the marker and the text. Defaults to 8.
    /// - Returns: An `NSAttributedString` representing the formatted list.
    public static func createList(
        for items: [String],
        type: ListType,
        font: UIFont = .systemFont(ofSize: 17, weight: .regular),
        markerAlignment: MarkerAlignment = .right,
        spacing: CGFloat = 8.0
    ) -> NSAttributedString {
        // Calculate the maximum width of the markers
        let markerFont = UIFont.monospacedSystemFont(ofSize: font.pointSize, weight: .regular)
        let markerWidth = markerWidth(for: type, itemCount: items.count, font: markerFont)

        // Define spacing between marker and text
        let firstLocation: CGFloat
        let secondLocation: CGFloat = markerWidth + spacing

        // Configure paragraph style for list formatting
        let alignment: NSTextAlignment
        switch markerAlignment {
        case .left:
            alignment = .left
            firstLocation = 1   // Set to 0 will cause unexpected layout behavior.
        case .right:
            alignment = .right
            firstLocation = markerWidth + 1
        }

        // Configure paragraph style for list formatting
        let tabStops = [
            NSTextTab(textAlignment: alignment, location: firstLocation),
            NSTextTab(textAlignment: .left, location: secondLocation)
        ]

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tabStops = tabStops
        paragraphStyle.headIndent = secondLocation
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = .byWordWrapping

        // Create attributed strings for each list item
        let markerAttributes: [NSAttributedString.Key: Any] = [
            .font: markerFont,
            .paragraphStyle: paragraphStyle
        ]
        let itemAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]

        let combinedAttr = NSMutableAttributedString()
        for (index, item) in items.enumerated() {
            let marker = marker(for: type, index: index)
            combinedAttr.append(NSAttributedString(string: "\t\(marker)\t", attributes: markerAttributes))
            combinedAttr.append(NSAttributedString(string: item, attributes: itemAttributes))

            if index < items.count - 1 {
                combinedAttr.append(NSAttributedString(string: "\n"))
            }
        }

        return combinedAttr
    }

    private static func markerWidth(for type: ListType, itemCount: Int, font: UIFont) -> CGFloat {
        // Calculate the maximum width of the markers
        switch type {
        case .ordered:
            var maxWidth: CGFloat = 0
            for index in 0..<itemCount {
                let marker = marker(for: type, index: index)
                let width = marker.size(withAttributes: [.font: font]).width
                if width > maxWidth {
                    maxWidth = width
                }
            }
            return maxWidth
        case .unordered:
            let marker = marker(for: type, index: 0)
            return marker.size(withAttributes: [.font: font]).width
        }
    }

    private static func marker(for type: ListType, index: Int) -> String {
        let marker: String

        switch type {
        case .ordered(let style):
            marker = MarkerGenerator.marker(for: style, number: index + 1)
        case .unordered(let style):
            marker = MarkerGenerator.marker(for: style)
        }

        return marker
    }
}
