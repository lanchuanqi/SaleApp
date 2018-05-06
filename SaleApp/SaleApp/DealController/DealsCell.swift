//
//  DealsCell.swift
//  SaleApp
//
//  Created by logan on 2018/4/13.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit

class DealsCell: UITableViewCell{
    var deal: Deal? {
        didSet{
            dateLabel.text = deal?.date
            nameLabel.text = deal?.name
            if let profit = deal?.profit{
                priceEarnLabel.text = "Earn \(profit)"
            }
        }
    }
    
    
    let dealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "select_photo_empty")
        imageView.layer.cornerRadius = 20
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
        label.text = "Item Name"
        return label
    }()
    
    let dateLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Roboto-Thin", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apr 12, 2018"
        return label
    }()
    
    let priceEarnLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Roboto-Thin", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Earn 20"
        return label
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
    }
    private func setUpView(){
        backgroundColor = UIColor.cellBackgroundColor
        addSubview(dealImageView)
        dealImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        dealImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        dealImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dealImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: dealImageView.rightAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(priceEarnLabel)
        priceEarnLabel.leftAnchor.constraint(equalTo: dealImageView.rightAnchor, constant: 10).isActive = true
        priceEarnLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        priceEarnLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        priceEarnLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        addSubview(dateLabel)
        dateLabel.leftAnchor.constraint(equalTo: dealImageView.rightAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: priceEarnLabel.bottomAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
