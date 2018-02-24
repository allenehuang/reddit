//
//  PostTableViewCell.swift
//  reddit
//
//  Created by Allen Huang on 2/24/18.
//  Copyright © 2018 Allen Huang. All rights reserved.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    static let reuseIdentifierString = "cell"
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let timeLabel = UILabel()
    private let numberOfCommentsLabel = UILabel()
    private let thumbnailImageView = UIImageView()
    private let authorTimeCommentsContainer = UIView()
    private let labelsContainer = UIView()

    convenience init() {
        self.init(style: .default, reuseIdentifier: PostTableViewCell.reuseIdentifierString)
        layoutViews()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        authorLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        timeLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        numberOfCommentsLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        thumbnailImageView.layer.borderColor = UIColor.red.cgColor
        thumbnailImageView.layer.borderWidth = 1.0

        authorTimeCommentsContainer.addSubviewsForAutolayout(authorLabel, timeLabel, numberOfCommentsLabel)
        labelsContainer.addSubviewsForAutolayout(titleLabel, authorTimeCommentsContainer)
        contentView.addSubviewsForAutolayout(thumbnailImageView, labelsContainer)
    }

    private func layoutViews() {
        let metrics: [String: Any] = [
            "spacing": 5
        ]

        let authorTimeCommentContainerViews: [String: Any] = [
            "authorLabel": authorLabel,
            "timeLabel": timeLabel,
            "commentsLabel": numberOfCommentsLabel
        ]

        authorTimeCommentsContainer.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[authorLabel]-spacing-[timeLabel]-(>=spacing)-[commentsLabel]|", options: [], metrics: metrics, views: authorTimeCommentContainerViews),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[timeLabel]|", options: [], metrics: metrics, views: authorTimeCommentContainerViews),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[commentsLabel]|", options: [], metrics: metrics, views: authorTimeCommentContainerViews),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[authorLabel]|", options: [], metrics: metrics, views: authorTimeCommentContainerViews)
        )

        let titleContainerViews: [String: Any] = [
            "authorTimeCommentsContainer": authorTimeCommentsContainer,
            "titleLabel": titleLabel
        ]

        labelsContainer.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[authorTimeCommentsContainer]|", options: [], metrics: metrics, views: titleContainerViews),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|", options: [], metrics: metrics, views: titleContainerViews),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]-spacing-[authorTimeCommentsContainer]|", options: [], metrics: metrics, views: titleContainerViews)
        )

        let views: [String: Any] = [
            "labelsContainer": labelsContainer,
            "thumbnailImageView": thumbnailImageView
        ]

        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-spacing-[labelsContainer]-spacing-[thumbnailImageView]-spacing-|", options: [], metrics: metrics, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-spacing-[labelsContainer]-spacing-|", options: [], metrics: metrics, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-spacing-[thumbnailImageView]-spacing-|", options: [], metrics: metrics, views: views)
        )
    }

    func configureWith(_ post: Post) {
        titleLabel.text = post.data.title
        authorLabel.text = post.data.author
        timeLabel.text = "time label"
        numberOfCommentsLabel.text = "\(post.data.numberOfComments) comments"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
