//
//  MainViewController.swift
//  TranslateLanguage
//
//  Created by yongcheol Lee on 2022/01/04.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateViewController = TranslateViewController()
        translateViewController.tabBarItem = UITabBarItem(
            title: LocalizedString.translate,
            image: UIImage(systemName: "mic"),
            selectedImage: UIImage(systemName: "mic.fill")
        )
        
        let bookmarkViewController = UINavigationController(rootViewController: BookmarkViewController())
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: LocalizedString.bookmark,
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        viewControllers = [translateViewController, bookmarkViewController]
    }
}
