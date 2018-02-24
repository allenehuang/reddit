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
    private let post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = .white

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItem = saveButton

        if let url = post.data.convertedURL {
            imageView.downloadImage(url: url)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
