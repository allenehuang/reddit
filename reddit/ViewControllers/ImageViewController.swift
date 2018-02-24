//
//  ImageViewController.swift
//  reddit
//
//  Created by Allen Huang on 2/24/18.
//  Copyright © 2018 Allen Huang. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController {
    private let imageView = UIImageView()
    private var post: Post?
    private var image: UIImage?

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviewsForAutolayout(imageView)
        restorationIdentifier = "ImageViewController"
        restorationClass = type(of: self)
        view.backgroundColor = .white
        layoutViews()

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItem = saveButton

        if let url = post?.data.convertedURL {
            imageView.downloadImage(url: url)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutViews() {
        let views: [String: Any] = [
            "imageView": imageView
        ]

        view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: views)
        )
    }

    @objc func didTapSaveButton() {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage(_:error:contextInfo:)), nil)
    }

    @objc func didFinishSavingImage(_ image: UIImage, error: Error?, contextInfo: UnsafeRawPointer) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        if let error = error {
            let alertViewController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alertViewController.addAction(okAction)
        } else {
            let alertViewController = UIAlertController(title: "Success", message: "Successfully saved image!", preferredStyle: .alert)
            alertViewController.addAction(okAction)
            navigationController?.present(alertViewController, animated: true, completion: nil)
        }
    }

    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(imageView.image, forKey: "image")
        super.encodeRestorableState(with: coder)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        image = coder.decodeObject(forKey: "image") as? UIImage

        if let image = image {
            imageView.image = image
        }

        super.decodeRestorableState(with: coder)
    }
}

extension ImageViewController: UIViewControllerRestoration {
    static func viewController(withRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        return ImageViewController()
    }
}
