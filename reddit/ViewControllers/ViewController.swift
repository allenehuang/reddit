//
//  ViewController.swift
//  reddit
//
//  Created by Allen Huang on 2/24/18.
//  Copyright © 2018 Allen Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var postsArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        fetchPosts()
    }

    private func fetchPosts() {
        SearchService.shared.getTopPosts(post: postsArray.last, completion: { [weak self] (posts, error) in
            if let posts = posts {
                self?.postsArray += posts
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        })
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifierString) as? PostTableViewCell
        if cell == nil {
            cell = PostTableViewCell()
        }
        cell?.configureWith(postsArray[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postsArray[indexPath.row]
        if post.data.type == "image" {
            let imageViewController = ImageViewController(post: post)
            navigationController?.pushViewController(imageViewController, animated: true)
        } else {
            guard let url = post.data.convertedURL else { return }
            UIApplication.shared.open(url, options: [:])
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height && scrollView.contentSize.height > 0{
            fetchPosts()
        }
    }
}
