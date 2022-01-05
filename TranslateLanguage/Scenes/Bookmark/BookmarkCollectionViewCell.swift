//
//  BookmarkCollectionViewCell.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/05.
//

import UIKit
import SnapKit

final class BookmarkCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookmarkCollectionViewCell"
    
    private var stackView = UIStackView()
    private var sourceTextStackView = BookmarkTextStackView()
    private var targetTextStackView = BookmarkTextStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12.0

        // stack view
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func layout() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 32.0)
        }
        
        [sourceTextStackView, targetTextStackView].forEach { stackView.addArrangedSubview($0) }
    }
}

extension BookmarkCollectionViewCell {
    func setData(_ bookmark: Bookmark) {
        sourceTextStackView.setData(
            language: bookmark.sourceLanguage.title,
            text: bookmark.sourceText,
            textColor: TranslateViewController.TranslateType.source.color
        )
        targetTextStackView.setData(
            language: bookmark.translatedLanguage.title,
            text: bookmark.translatedText,
            textColor: TranslateViewController.TranslateType.target.color
        )
    }
}
