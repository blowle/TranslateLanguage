//
//  TranslateViewController.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/05.
//

import UIKit
import SnapKit

final class TranslateViewController: UIViewController {
    private lazy var sourceLanguagebutton: UIButton = {
        let button = UIButton()
        button.setTitle("한국어", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        return button
    }()
    
    private lazy var targetLanguagebutton: UIButton = {
        let button = UIButton()
        button.setTitle("영어", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        [sourceLanguagebutton, targetLanguagebutton]
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
        return button
    }()
    
    private lazy var resultCopyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = UIColor.mainTintColor
        return button
    }()
    
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
        // TODO: sourceLabel에 입력값이 추가되면, placeholder 스타일 해제
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
    
    @objc private func didTapSourceLabelBaseButton() {
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true, completion: nil)
    }
}

extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
    }
}
