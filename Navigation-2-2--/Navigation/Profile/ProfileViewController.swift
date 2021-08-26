//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Artemiy Zuzin on 30.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet private weak var navigationBar: UINavigationItem!
    @IBOutlet private weak var headerView: ProfileHeaderView!
    
    private let cellid = "post"
    private let logInViewControler = LogInViewController()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
                        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellid)
        
        let constraints = [tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        
                           NSLayoutConstraint.activate(constraints)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat { 220 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    { UITableView.automaticDimension }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { headerView }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { posts.count + 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row != 0 else {
            let cell = PhotosTableViewCell()
            
            var image = [UIImageView]()
            
            for i in 0 ..< posts.count {
                
                image.append(UIImageView(image: UIImage(named: posts[i].image)))
            }
            
            cell.images = image
            
            return cell
        }
        
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellid,
                                          for: indexPath) as! PostTableViewCell
        
        cell.post = posts[indexPath.row - 1]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let photosController = PhotosViewController()
            
            var images = [UIImageView]()
    
            for i in 0 ..< posts.count {
                images.append(UIImageView(image: UIImage(named: posts[i].image)))
            }
                
            photosController.images = images
            
            navigationController?.pushViewController(photosController, animated: true)
        }
    }
}
