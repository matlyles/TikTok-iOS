//
//  CommentItemCell.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/2/21.
//

import UIKit
import SDWebImage

class CommentItemCell: UITableViewCell {
    
    static let identifier = String(describing: CommentItemCell.self)
    
    private let avatarImageView: UIImageView = {
       let img = UIImageView()
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 20
        return img
    }()
    
    private let commentLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let usernameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13, weight: .bold)
        lbl.numberOfLines = 1
        lbl.textColor = .white
        return lbl
    }()
    
    private let dateLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        lbl.numberOfLines = 1
        lbl.textColor = UIColor.white.withAlphaComponent(0.6)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with model: PostComment) {
        if let url = model.user.profileImageUrl {
            avatarImageView.sd_setImage(with: url)
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle.full", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        }
        commentLabel.text = model.text
        usernameLabel.text = "@\(model.user.username)"
        dateLabel.text = "  •  \(model.date.timeAgo()) ago"
        print(model.date.timeAgo())
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.setDimensions(width: 40, height: 40)
        avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        avatarImageView.centerY(inView: self)
        
        usernameLabel.apply(top: avatarImageView.topAnchor, left: avatarImageView.rightAnchor, paddingTop: 0, paddingLeft: 12)
        dateLabel.apply(top: avatarImageView.topAnchor, left: usernameLabel.rightAnchor, paddingTop: 0, paddingLeft: 0)
        commentLabel.apply(top: usernameLabel.bottomAnchor, left: avatarImageView.rightAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingRight: 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        commentLabel.text = nil
        usernameLabel.text = nil
        dateLabel.text = nil
    }
    
    private func configureUI() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
    }
    
}
