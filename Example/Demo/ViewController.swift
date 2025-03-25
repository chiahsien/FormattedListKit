//
//  ViewController.swift
//  Demo
//
//  Created by Nelson on 2025/3/24.
//

import UIKit
import ListFormatter
import Combine

final class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    @Published private var alignment: MarkerAlignment = .left
    @Published private var type: ListType = .ordered(style: .decimal)

    private var cancelables: Set<AnyCancellable> = []
    private let items: [String] = [
        // English
        "Apple", "The quick brown fox", "Hello world", "Swift programming", "Short", "A very long sentence to test scrolling functionality in the list A very long sentence to test scrolling functionality in the list",
        // Chinese
        "蘋果", "快速的棕色狐狸", "你好世界", "程式設計", "短", "這是一個很長的句子用來測試列表的滾動功能 這是一個很長的句子用來測試列表的滾動功能",
        // Japanese
        "リンゴ", "速い茶色のキツネ", "こんにちは世界", "プログラミング", "短い", "スクロール機能をテストするための非常に長い文 スクロール機能をテストするための非常に長い文",
        // Korean
        "사과", "빠른 갈색 여우", "안녕하세요 세계", "프로그래밍", "짧은", "리스트の 스크롤 기능을 테스트하기 위한 매우 긴 문장 리스트の 스크롤 기능을 테스트하기 위한 매우 긴 문장",
        // Thai
        "แอปเปิ้ล", "จิ้งจอกสีน้ำตาลเร็ว", "สวัสดีชาวโลก", "การเขียนโปรแกรม", "สั้น", "ประโยคที่ยาวมากเพื่อทดสอบการเลื่อนของรายการ ประโยคที่ยาวมากเพื่อทดสอบการเลื่อนของรายการ"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        Publishers.CombineLatest($alignment, $type)
            .sink { [weak self] alignment, type in
                guard let self else { return }
                updateList(withMarkAlignment: alignment, markerType: type)
            }
            .store(in: &cancelables)
    }

    @IBAction func markerAlignmentDidChange(_ sender: UISegmentedControl) {
        alignment = sender.selectedSegmentIndex == 0 ? .left : .right
    }

    @IBAction func markerTypeDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: type = .ordered(style: .decimal)
        case 1: type = .ordered(style: .upperAlpha)
        case 2: type = .ordered(style: .lowerRoman)
        case 3: type = .unordered(style: .square)
        case 4: type = .unordered(style: .custom("★"))
        default: type = .ordered(style: .decimal)
        }
    }

    private func updateList(withMarkAlignment alignment: MarkerAlignment, markerType: ListType) {
        textView.attributedText = NSAttributedString.createList(for: items, type: markerType, font: .systemFont(ofSize: 17), markerAlignment: alignment)
    }
}
