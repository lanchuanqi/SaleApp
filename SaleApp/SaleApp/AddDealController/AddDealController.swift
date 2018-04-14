//
//  AddDealController.swift
//  SaleApp
//
//  Created by logan on 2018/4/9.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit


class AddDealController: UIViewController{
    var client: Client?
    var deal: Deal? {
        didSet{
            nameTextField.text = deal?.name
            priceTextField.text = deal?.price
            sellPriceTextField.text = deal?.sellPrice
            shippingTextField.text = deal?.shipNumber
            if let shipString = deal?.shipped{
                if Int(shipString) == 1{
                    shippedSwitch.isOn = true
                } else if Int(shipString) == 0{
                    shippedSwitch.isOn = false
                }
            }
            if let imageUrl = deal?.image{
                if imageUrl != "None"{
                    dealImageView.downLoadAndCacheImageFromURL(urlString: imageUrl)
                }
            }
        }
    }
    var selectedImage: UIImage?
    
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter item name"
        return tf
    }()
    let priceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let priceTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter item price"
        return tf
    }()
    let sellPriceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sell Price"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let sellPriceTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter item sell price"
        return tf
    }()
    let shippingLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping#"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let shippingTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter shipping number"
        return tf
    }()
    let shippedLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipped"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let shippedSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    lazy var dealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = #imageLiteral(resourceName: "select_photo_empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClientPhotoSelect)))
        return imageView
    }()
    
    private func setUpUI(){
        let _ = setUpLightBlueBackgroundView(height: 360)
        view.addSubview(dealImageView)
        dealImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        dealImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dealImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dealImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: dealImageView.bottomAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(priceLabel)
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(priceTextField)
        priceTextField.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 10).isActive = true
        priceTextField.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        priceTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        priceTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(sellPriceLabel)
        sellPriceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        sellPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor).isActive = true
        sellPriceLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sellPriceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(sellPriceTextField)
        sellPriceTextField.leftAnchor.constraint(equalTo: sellPriceLabel.rightAnchor, constant: 10).isActive = true
        sellPriceTextField.topAnchor.constraint(equalTo: sellPriceLabel.topAnchor).isActive = true
        sellPriceTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sellPriceTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(shippingLabel)
        shippingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        shippingLabel.topAnchor.constraint(equalTo: sellPriceLabel.bottomAnchor).isActive = true
        shippingLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shippingLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(shippingTextField)
        shippingTextField.leftAnchor.constraint(equalTo: shippingLabel.rightAnchor, constant: 10).isActive = true
        shippingTextField.topAnchor.constraint(equalTo: shippingLabel.topAnchor).isActive = true
        shippingTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shippingTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(shippedLabel)
        shippedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        shippedLabel.topAnchor.constraint(equalTo: shippingLabel.bottomAnchor).isActive = true
        shippedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shippedLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(shippedSwitch)
        shippedSwitch.leftAnchor.constraint(equalTo: shippedLabel.rightAnchor, constant: 10).isActive = true
        shippedSwitch.centerYAnchor.constraint(equalTo: shippedLabel.centerYAnchor).isActive = true
        shippedSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        shippedSwitch.widthAnchor.constraint(equalToConstant: 47).isActive = true
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlue
        hideKeyboardWhenTappedAround()
        setUpNavigationBar()
        setUpUI()
    }
    
    
    private func setUpNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let name = client?.name{
            navigationItem.title = "Add Deal for \(name)"
        } else {
            navigationItem.title = "Add Deal"
        }
        
    }
    
    
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
}
