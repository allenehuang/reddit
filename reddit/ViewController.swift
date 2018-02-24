//
//  ViewController.swift
//  reddit
//
//  Created by Allen Huang on 2/24/18.
//  Copyright © 2018 Allen Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    var postsArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SearchService.shared.getTopPosts { [weak self] (posts, error) in
            if let posts = posts {
                self?.postsArray = posts
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifierString) as? PostTableViewCell
        if cell == nil {
            cell = PostTableViewCell()
        }
        cell?.configureWith(self.postsArray[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsArray.count
    }
}

