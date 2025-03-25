import Testing
import UIKit
@testable import ListFormatter

struct MarkerGeneratorTests {
    // MARK: - Roman Numeral Tests

    @Test("Roman numeral conversion", arguments: [
        (1, false, "i"), (4, true, "IV"), (10, false, "x"), (1999, true, "MCMXCIX"),
        (5, false, "v"), (9, true, "IX"), (50, false, "l"), (100, true, "C")
    ])
    func testRomanNumeral(number: Int, isUpper: Bool, expected: String) {
        let result = MarkerGenerator.romanNumeral(for: number, isUpper: isUpper)
        #expect(result == expected)
    }

    // MARK: - Alpha Numeral Tests

    @Test("Alpha numeral conversion", arguments: [
        (1, false, "a"), (2, true, "B"), (27, false, "aa"), (52, true, "AZ"),
        (3, false, "c"), (26, true, "Z"), (28, false, "ab"), (702, true, "ZZ")
    ])
    func testAlphaNumeral(number: Int, isUpper: Bool, expected: String) {
        let result = MarkerGenerator.alphaNumeral(for: number, isUpper: isUpper)
        #expect(result == expected)
    }

    // MARK: - Marker Tests

    @Test("Ordered list marker generation", arguments: [
        (0, OrderedListStyle.decimal, "1."),
        (1, OrderedListStyle.lowerRoman, "ii."),
        (2, OrderedListStyle.upperRoman, "III."),
        (3, OrderedListStyle.lowerAlpha, "d."),
        (25, OrderedListStyle.upperAlpha, "Z.")
    ])
    func testOrderedMarker(index: Int, style: OrderedListStyle, expected: String) {
        let result = MarkerGenerator.marker(for: style, number: index + 1)
        #expect(result == expected)
    }

    @Test("Unordered list marker generation", arguments: [
        (0, UnorderedListStyle.disc, "•"),
        (1, UnorderedListStyle.circle, "◦"),
        (2, UnorderedListStyle.square, "▪"),
        (3, UnorderedListStyle.custom("★"), "★")
    ])
    func testUnorderedMarker(index: Int, style: UnorderedListStyle, expected: String) {
        let result = MarkerGenerator.marker(for: style)
        #expect(result == expected)
    }
}
