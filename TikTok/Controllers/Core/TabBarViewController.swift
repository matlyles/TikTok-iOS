//
//  TabBarViewController.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        let home = createNavControllerTabBarItem(controller: HomeViewController(), title: "Home", image: "house", selectedImage: "house.fill", tag: 1)
        let explore = createNavControllerTabBarItem(controller: ExploreViewController(), title: "Explore", image: "safari", selectedImage: "safari.fill", tag: 2)
        let camera = createNavControllerTabBarItem(controller: CameraViewController(), title: "Camera", image: "camera", selectedImage: "camera.fill", tag: 3)
        let notifications = createNavControllerTabBarItem(controller: NotificationsViewController(), title: "Notifications", image: "bell", selectedImage: "bell.fill", tag: 4)
        let profile = createNavControllerTabBarItem(controller: ProfileViewController(), title: "Profile", image: "person", selectedImage: "person.fill", tag: 5)
        
        setViewControllers([home, explore, camera, notifications, profile], animated: false)
        self.tabBar.unselectedItemTintColor = .secondaryLabel
        self.tabBar.tintColor = .label
    }
    
    func createNavControllerTabBarItem(controller: UIViewController,
                                       title: String,
                                       image: String,
                                       selectedImage: String,
                                       tag: Int) -> UINavigationController {
        controller.title = title
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: image), tag: tag)
        nav.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        return nav
    }
    

}
