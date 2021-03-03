//
//  PostViewController.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import UIKit

class PostViewController: UIViewController {
    
    var model: PostModel
    
    let actionStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let likeButton: UIButton = {
        let btn = UIButton()
        let imgConfig = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34))
        btn.contentMode = .scaleAspectFit
        btn.setImage(imgConfig, for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private let commentButton: UIButton = {
        let btn = UIButton()
        let imgConfig = UIImage(systemName: "message.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))
        btn.setImage(imgConfig, for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.tintColor = .white
        return btn
    }()
    
    private let shareButton: UIButton = {
        let btn = UIButton()
        let imgConfig = UIImage(systemName: "arrowshape.turn.up.right.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))
        btn.setImage(imgConfig, for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.tintColor = .white
        return btn
    }()
    
    private let userAvatar: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        return img
    }()
    
    private let usernameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    private let captionLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let commentsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = [.red, .gray, .green, .blue, .purple, .brown, .cyan, .orange, .systemPink].randomElement()
        setupButtons()
        setupDoubleTapLike()
    }
    
    func setupButtons() {
        actionStackView.addArrangedSubview(likeButton)
        actionStackView.addArrangedSubview(commentButton)
        actionStackView.addArrangedSubview(shareButton)
        view.addSubview(actionStackView)
        
        userAvatar.image = #imageLiteral(resourceName: "77")
        usernameLabel.text = "Straight Savage"
        captionLabel.text = "this is some text and i do what i want , yea i do what i want now, so F you!"
        let userStack = UIStackView(arrangedSubviews: [
            userAvatar, usernameLabel
        ])
        //userStack.distribution = .fill
        userStack.axis = .horizontal
        userStack.spacing = 15
        userStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        commentsStackView.addArrangedSubview(userStack)
        commentsStackView.addArrangedSubview(captionLabel)
        view.addSubview(commentsStackView)
        
        likeButton.addTarget(self, action: #selector(handleDidTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(handleDidTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(handleDidTapShare), for: .touchUpInside)
    }
    
    func setupDoubleTapLike() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        print("yo")
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
     
        if !model.isLikedByCurrentUser {
            model.isLikedByCurrentUser = true
        }
        let touchPoint = gesture.location(in: view)
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .white
        view.addSubview(imageView)
        imageView.frame = .init(x: 0, y: 0, width: 200, height: 200)
        imageView.center = touchPoint
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFit
        
        UIView.animate(withDuration: 0.2, delay: 0.1) {
            imageView.alpha = 0.8
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.9) {
                    imageView.alpha = 0
                } completion: { done in
                    if done {
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.1) {
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    @objc func handleDidTapLike() {
     print("did tap like")
        model.isLikedByCurrentUser = !model.isLikedByCurrentUser
        likeButton.tintColor = model.isLikedByCurrentUser ? .systemPink : .white
    }
    
    @objc func handleDidTapComment() {
        print("did tap comment")
    }
    
    @objc func handleDidTapShare() {
        print("did tap share")
        let url = URL(string: "http://www.mathewlyles.com")
        let shareVC = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(shareVC, animated: true, completion: nil)
    }

    
    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            actionStackView.widthAnchor.constraint(equalToConstant: 55),
            actionStackView.heightAnchor.constraint(equalToConstant: 52*3),
            actionStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            actionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            userAvatar.widthAnchor.constraint(equalToConstant: 40),
            commentsStackView.widthAnchor.constraint(equalToConstant: view.frame.width-100),
            commentsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            commentsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
        ])
    }
    
}
