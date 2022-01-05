//
//  BookmarkTextStackView.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/05.
//

import UIKit
import SnapKit

final class BookmarkTextStackView: UIStackView {
    private lazy var languageLabel = UILabel()
    private lazy var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        languageLabel.numberOfLines = 0
        textLabel.numberOfLines = 0
        languageLabel.font = .systemFont(ofSize: 13.0, weight: .light)
        textLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    
    private func layout() {
        axis = .vertical
        alignment = .leading
        distribution = .equalSpacing
        spacing = 4.0
        
        [languageLabel, textLabel].forEach {
            addArrangedSubview($0)
        }
    }
}

extension BookmarkTextStackView {
    func setData(language: String, text: String, textColor: UIColor) {
        languageLabel.text = language
        textLabel.text = text
        languageLabel.textColor = textColor
        textLabel.textColor = textColor 
    }
}
