//
//  CommentsViewController.swift
//  TikTok
//
//  Created by Matthew Lyles on 3/2/21.
//

import UIKit

protocol CommentsControllerDelegate {
    func didTapCloseComments(with vc: CommentsViewController)
}

class CommentsViewController: UIViewController {
    
    var delegate: CommentsControllerDelegate?
    private let post: PostModel
    private var comments: [PostComment] = []
    
    private let commentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(CommentItemCell.self, forCellReuseIdentifier: CommentItemCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    private let closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.tintColor = .white
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        return btn
    }()
    
    private let modalTitleLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .white
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        setup()
        fetchPostComments()
    }
    
    init(post: PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeCommentsTray() {
        delegate?.didTapCloseComments(with: self)
    }
    
    func fetchPostComments() {
        comments = PostComment.mockComments()
        modalTitleLabel.text = "Comments  •  \(comments.count)"
        commentsTableView.reloadData()
    }
    
    func setup() {
        
        view.addSubview(modalTitleLabel)
        view.addSubview(commentsTableView)
        closeButton.addTarget(self, action: #selector(closeCommentsTray), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        modalTitleLabel.frame = .init(x: 18, y: 22, width: view.width/2, height: 20)
        commentsTableView.fillSuperview(padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        closeButton.setDimensions(width: 50, height: 50)
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 7).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7).isActive = true
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentItemCell.identifier, for: indexPath) as! CommentItemCell
        cell.separatorInset = .init(top: 79, left: 0, bottom: 0, right: 0)
        let comment = comments[indexPath.row]
        cell.setup(with: comment)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
