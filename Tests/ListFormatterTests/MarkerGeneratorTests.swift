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
        (0, ListType.ordered(style: .decimal), "1."),
        (1, ListType.ordered(style: .lowerRoman), "ii."),
        (2, ListType.ordered(style: .upperRoman), "III."),
        (3, ListType.ordered(style: .lowerAlpha), "d."),
        (25, ListType.ordered(style: .upperAlpha), "Z.")
    ])
    func testOrderedMarker(index: Int, type: ListType, expected: String) {
        let font = UIFont.systemFont(ofSize: 17)
        let result = MarkerGenerator.marker(for: index, type: type, font: font)
        #expect(result.string == expected)
    }

    @Test("Unordered list marker generation", arguments: [
        (0, ListType.unordered(style: .disc), "•"),
        (1, ListType.unordered(style: .circle), "◦"),
        (2, ListType.unordered(style: .square), "▪"),
        (3, ListType.unordered(style: .custom("★")), "★")
    ])
    func testUnorderedMarker(index: Int, type: ListType, expected: String) {
        let font = UIFont.systemFont(ofSize: 17)
        let result = MarkerGenerator.marker(for: index, type: type, font: font)
        #expect(result.string == expected)
    }
}
