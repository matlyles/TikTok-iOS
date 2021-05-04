//
//  ProfileViewController.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user.username.uppercased()
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
//        self.tabBarController?.tabBar.unselectedItemTintColor = .label
//        self.tabBarController?.tabBar.tintColor = .label
//        self.tabBarController?.tabBar.barTintColor = .systemBackground
//        self.tabBarController?.tabBar.isOpaque = true
//        self.tabBarController?.tabBar.isTranslucent = true
    }
    
}
