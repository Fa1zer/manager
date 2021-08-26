//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Artemiy Zuzin on 30.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    var user: User? {
        didSet {
            avatarImageView.image = UIImage(named: user!.image)
            fullNameLabel.text = user!.name
            statusLabel.text = user!.status
        }
    }
    
    private var statusText = "Вы можете добавить статус"
    
    internal let avatarImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)

        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let fullNameLabel: UILabel = {
        let name = UILabel()

        name.textColor = .black
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        name.translatesAutoresizingMaskIntoConstraints = false

        return name
    }()

    private let setStatusButton: UIButton = {
        let button = UIButton()

        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.addTarget(self, action: #selector(buttonPressed),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let statusLabel: UILabel = {
        let status = UILabel()

        status.textColor = .gray
        status.textAlignment = .center
        status.font = UIFont.systemFont(ofSize: 14,
                                        weight: UIFont.Weight.regular)
        status.textAlignment = .left
        status.translatesAutoresizingMaskIntoConstraints = false

        return status
    }()

    private let setStatusTextField: UITextField = {
        var edit = UITextField()

        edit.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        edit.tintColor = .black
        edit.backgroundColor = .white
        edit.layer.cornerRadius = 12
        edit.layer.borderWidth = 1
        edit.layer.borderColor = UIColor.black.cgColor
        edit.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        edit.translatesAutoresizingMaskIntoConstraints = false
        edit.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        edit.leftViewMode = .always
        edit.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        edit.rightViewMode = .always

        return edit
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .systemGray6
        
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusTextField)
        addSubview(setStatusButton)


        insertSubview(avatarImageView, at: 6)
        insertSubview(setStatusButton, at: 1)

        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        
        fullNameLabel.sizeToFit()

        avatarImageView.snp.makeConstraints({ make in
            make.width.height.equalTo(safeAreaLayoutGuide.snp.width).inset(4).multipliedBy(0.25)
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
        })
        
        translatesAutoresizingMaskIntoConstraints = false

        fullNameLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).inset(27)
            make.width.equalTo(fullNameLabel.frame.width)
        })

        statusLabel.snp.makeConstraints({ make in
            make.leading.equalTo(fullNameLabel)
            make.top.equalTo(avatarImageView.snp.bottom).inset(27)
        })

        setStatusTextField.snp.makeConstraints({ make in
            make.leading.equalTo(statusLabel)
            make.top.equalTo(statusLabel.snp.bottom).inset(-11)
            make.trailing.equalTo(setStatusButton)
            make.height.equalTo(40)
        })

        setStatusButton.snp.makeConstraints({ make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(setStatusTextField.snp.bottom).inset(-16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(40)
        })
        
        snp.makeConstraints({ make in
            make.bottom.equalTo(setStatusButton).inset(-16)
            make.top.equalTo(avatarImageView).inset(-16)
        })
    }

    @objc fileprivate func buttonPressed() {
        print(statusLabel.text!)

        statusLabel.text = statusText
        statusLabel.sizeToFit()
    }

    @objc func statusTextChanged(_ sender: UITextField) {
        statusText = setStatusTextField.text!
    }
    
    
}
