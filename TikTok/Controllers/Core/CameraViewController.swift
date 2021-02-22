//
//  CameraViewController.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.unselectedItemTintColor = .white
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarController?.tabBar.barTintColor = .black
        self.tabBarController?.tabBar.isOpaque = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
}
