//
//  TranslateViewController.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/05.
//

import UIKit
import SnapKit

final class TranslateViewController: UIViewController {
    enum TranslateType {
        case source
        case target
        
        var color: UIColor {
            switch self {
            case .source: return .label
            case .target: return .mainTintColor
            }
        }
    }
    
    private var sourceLanguage: Language = .ko
    private var targetLanguage: Language = .en
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didSourceLanguageButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTargetLanguageButtonTap), for: .touchUpInside)
        
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        [sourceLanguageButton, targetLanguageButton]
            .forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.textColor = UIColor.mainTintColor
        label.text = "Hello"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var resultBookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = UIColor.mainTintColor
        
        button.addTarget(self, action: #selector(didBookmarkbuttonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var resultCopyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = UIColor.mainTintColor
        
        button.addTarget(self, action: #selector(didCopyButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    @objc func didCopyButtonTap() {
        UIPasteboard.general.string = resultLabel.text
    }
    
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSourceLabelBaseButton))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트 입력"
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23.0, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupViews()
    }
}

private extension TranslateViewController {
    
    func setupViews() {
        [
            buttonStackView,
            resultBaseView,
            resultLabel,
            resultBookmarkButton,
            resultCopyButton,
            sourceLabelBaseButton,
            sourceLabel
        ]
            .forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 16.0
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50.0)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalTo(resultBookmarkButton).offset(defaultSpacing)
        }
        
        resultLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(resultBaseView).inset(24.0)
        }
        
        resultBookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLabel.snp.leading)
            $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
            $0.width.height.equalTo(40.0)
        }
        resultCopyButton.snp.makeConstraints {
            $0.leading.equalTo(resultBookmarkButton.snp.trailing).offset(8.0)
            $0.centerY.equalTo(resultBookmarkButton)
            $0.width.height.equalTo(40.0)
        }
        
        sourceLabelBaseButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(sourceLabelBaseButton).inset(24.0)
        }
    }
    
    @objc func didTapSourceLabelBaseButton() {
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func didSourceLanguageButtonTap() {
        didLanguageButtonTap(type: .source)
    }
    
    @objc func didTargetLanguageButtonTap() {
        didLanguageButtonTap(type: .target)
    }
    
    func didLanguageButtonTap(type: TranslateType) {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        Language.allCases.forEach { lang in
            let action = UIAlertAction(
                title: lang.title,
                style: .default,
                handler: { [weak self] _ in
                    switch type {
                    case .source:
                        self?.sourceLanguageButton.setTitle(lang.title, for: .normal)
                        self?.sourceLanguage = lang
                    case .target:
                        self?.targetLanguageButton.setTitle(lang.title, for: .normal)
                        self?.targetLanguage = lang
                    }
                }
            )
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "취소하기", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = .systemPink
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func didBookmarkbuttonTap() {
        guard let sourceText = sourceLabel.text,
              let translatedText = resultLabel.text,
              resultBookmarkButton.imageView?.image == UIImage(systemName: "bookmark")
        else { return }
        
        let currentBookmarks: [Bookmark] = UserDefaults.standard.bookmarks
        let newBookmark: Bookmark = Bookmark(
            sourceLanguage: sourceLanguage,
            translatedLanguage: targetLanguage,
            sourceText: sourceText,
            translatedText: translatedText)
        
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
        
        resultBookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
    }
    
}

extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
        
        resultBookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
//        TranslatorManager.shared.sourceLanguage = sourceLanguage
//        TranslatorManager.shared.targetLanguage = targetLanguage
//        TranslatorManager.shared.translate(from: sourceText) { [weak self] translatedText in
//            self?.resultLabel.text = translatedText
//        }
        
        PapagoNetwork().translate(
            source: sourceLanguage.translateCode,
            target: targetLanguage.translateCode,
            text: sourceText,
            completionHandler: { [weak self] translatedText in
                self?.resultLabel.text = translatedText
            },
            ErrorHandler: { error in
                print(error?.localizedDescription)
            })
    }
}
