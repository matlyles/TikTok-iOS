//
//  ViewController.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .black
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    
    let control: UISegmentedControl = {
        let titles = ["Following", "For You"]
        let control = UISegmentedControl(items: titles)
        let titleSelected = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .black)]
        let titleNormal = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]
        control.setTitleTextAttributes(titleNormal, for: .normal)
        control.setTitleTextAttributes(titleSelected, for: .selected)
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = .clear
        control.tintColor = .clear
        control.selectedSegmentIndex = 1
        return control
    }()
    
    let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    let followingFeedViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        setupFeed()
        horizontalScrollView.delegate = self
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setupHeaderButtons()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.unselectedItemTintColor = .white
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarController?.tabBar.barTintColor = .black
        self.tabBarController?.tabBar.isOpaque = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewDidLayoutSubviews() {
        horizontalScrollView.frame = view.bounds
    }

    // MARK: - Methods
    func setupHeaderButtons() {
        control.addTarget(self, action: #selector(handleDidChangeSegmentControl(_:)), for: .valueChanged)
        navigationItem.titleView = control
    }
    
    private func setupFeed() {
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        setupFollowingFeed()
        setupForYouFeed()
    }
    
    fileprivate func setupFollowingFeed() {
        // set up paging controller
        guard let model = followingPosts.first else {
            return
        }
        let post = PostViewController(model: model)
        post.delegate = self
        
        followingFeedViewController.setViewControllers(
            [post],
            direction: .forward,
            animated: false,
            completion: nil
        )
        followingFeedViewController.dataSource = self
        
        horizontalScrollView.addSubview(followingFeedViewController.view)
        followingFeedViewController.view.frame = CGRect(x: 0, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(followingFeedViewController)
        followingFeedViewController.didMove(toParent: self)
    }
    
    fileprivate func setupForYouFeed() {
        // set up paging controller
        guard let model = forYouPosts.first else {
            return
        }
        let post = PostViewController(model: model)
        post.delegate = self
        
        forYouPageViewController.setViewControllers(
            [post],
            direction: .forward,
            animated: false,
            completion: nil
        )
        forYouPageViewController.dataSource = self
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(x: view.width, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
    }
    
    // MARK: - OBJEC Methods
    @objc func handleDidChangeSegmentControl(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        horizontalScrollView.setContentOffset(CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
    }

}

// MARK: - Extensions

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else { return nil }
        
        if index == 0 {
            return nil
        }
        let priorIndex = index - 1
        let model = currentPosts[priorIndex]
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else { return nil }
        
        guard index < (currentPosts.count - 1) else {
            return nil
        }
        let nextIndex = index + 1
        let model = currentPosts[nextIndex]
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    
    var currentPosts: [PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            //in following
            return followingPosts
        }
        // in for you
        return forYouPosts
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            control.selectedSegmentIndex = 0
        } else if scrollView.contentOffset.x > (view.width/2) {
            control.selectedSegmentIndex = 1
        }
    }
}

extension HomeViewController: PostControllerDelegate {
    
    func loadProfileViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel) {
        print("did Tap got to profile")
        let user = post.user
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }

    func loadCommentsViewController(_ vc: PostViewController, didTapCommentButtonFor post: PostModel) {
        horizontalScrollView.isScrollEnabled = false
        if horizontalScrollView.contentOffset.x == 0 {
            // is following
            followingFeedViewController.dataSource = nil
        } else {
            // for you
            forYouPageViewController.dataSource = nil
        }
        let vc = CommentsViewController(post: post)
        vc.delegate = self
        addChild(vc)
        vc.didMove(toParent: self)
        view.addSubview(vc.view)
        
        let frame: CGRect = .init(x: 0, y: view.height, width: view.width, height: view.height * 0.76)
        vc.view.frame = frame
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            vc.view.frame = .init(x: 0, y: self.view.height - frame.height, width: frame.width, height: frame.height)
        }
    }

}


extension HomeViewController: CommentsControllerDelegate {
    
    func didTapCloseComments(with vc: CommentsViewController) {
        UIView.animate(withDuration: 0.2) {
            vc.view.frame = .init(x: 0, y: self.view.height+10, width: vc.view.width, height: vc.view.height)
        } completion: { [unowned self] done in
            if done {
                DispatchQueue.main.async {
                    vc.view.removeFromSuperview()
                    vc.removeFromParent()
                    self.horizontalScrollView.isScrollEnabled = true
                    self.followingFeedViewController.dataSource = self
                    self.forYouPageViewController.dataSource = self
                }
            }
        }
    }
    
}
