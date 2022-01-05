//
//  BookmarkViewController.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/05.
//

import UIKit
import SnapKit

final class BookmarkViewController: UIViewController {
    
    private var bookmarks: [Bookmark] = []
    
    private lazy var bookmarkList: UICollectionView = {
        let inset: CGFloat = 16.0
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = 16.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .secondarySystemBackground
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "즐겨찾기"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .secondarySystemBackground
        
        bookmarkList.dataSource = self
        bookmarkList.delegate = self
        
        registerCells()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookmarks = UserDefaults.standard.bookmarks
        bookmarkList.reloadData()
    }
    
    private func registerCells() {
        bookmarkList.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
    }
    
    private func layout() {
        view.addSubview(bookmarkList)
        bookmarkList.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
 
extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier, for: indexPath) as? BookmarkCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setData(bookmarks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 32.0
        let height = collectionView.cellForItem(at: indexPath)?.frame.height ?? 0.0
        
        return CGSize(width: width, height: height)
    }
}
