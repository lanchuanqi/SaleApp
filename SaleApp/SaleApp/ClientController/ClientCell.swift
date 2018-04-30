//
//  ClientCell.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit

class ClientCell: UITableViewCell{
    let clientImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "profile2")
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        return imageView
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Client Name"
        return label
    }()
    
    let profitLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Roboto-Thin", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Profit: 20"
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
    }
    private func setUpView(){
        backgroundColor = UIColor.cellBackgroundColor
        addSubview(clientImageView)
        clientImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        clientImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        clientImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        clientImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: clientImageView.rightAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(profitLabel)
        profitLabel.leftAnchor.constraint(equalTo: clientImageView.rightAnchor, constant: 10).isActive = true
        profitLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        profitLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        profitLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
