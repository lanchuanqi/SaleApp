//
//  AddClientController.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase

class AddClientController: UIViewController{
    var selectedImage: UIImage?
    var currentClient: Client? {
        didSet{
            nameTextField.text = currentClient?.name
            phoneNumberTextField.text = currentClient?.phone
            idTextField.text = currentClient?.id
            addressTextView.text = currentClient?.address
            if let url = currentClient?.image{
                if url != "None"{
                    clientImageView.downLoadAndCacheImageFromURL(urlString: url)
                }
            }
            if let role = currentClient?.role{
                if role == ClientRole.Agency.rawValue{
                    self.clientTypeSegmentControl.selectedSegmentIndex = 0
                } else {
                    self.clientTypeSegmentControl.selectedSegmentIndex = 1
                }
            }
        }
    }
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    let nameTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Name"
        return textField
    }()
    let addressLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Address"
        return label
    }()
    let addressTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.boldSystemFont(ofSize: 15)
        return textView
    }()
    let phoneNumberLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone"
        return label
    }()
    let phoneNumberTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Phone Number"
        return textField
    }()
    let idLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ID Number"
        return label
    }()
    let idTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter ID#"
        return textField
    }()
    
    lazy var clientImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = #imageLiteral(resourceName: "profile2")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClientPhotoSelect)))
        return imageView
    }()
    
    let clientTypeSegmentControl: UISegmentedControl = {
        let type = [ClientRole.Agency.rawValue,
                    ClientRole.Customer.rawValue]
        var sc = UISegmentedControl(items: type)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 1
        sc.tintColor = UIColor.lightRed
        return sc
    }()
    
    
    private func setUpUI(){
        let _ = setUpLightBlueBackgroundView(height: 345)
        
        view.addSubview(clientImageView)
        clientImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        clientImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clientImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        clientImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: clientImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        view.addSubview(phoneNumberLabel)
        phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        phoneNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        phoneNumberLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        phoneNumberLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.leftAnchor.constraint(equalTo: phoneNumberLabel.rightAnchor).isActive = true
        phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.topAnchor).isActive = true
        phoneNumberTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        phoneNumberTextField.bottomAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor).isActive = true
        
        view.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor).isActive = true
        idLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        idLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(idTextField)
        idTextField.leftAnchor.constraint(equalTo: idLabel.rightAnchor).isActive = true
        idTextField.topAnchor.constraint(equalTo: idLabel.topAnchor).isActive = true
        idTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        idTextField.bottomAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
        
        view.addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        addressLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(addressTextView)
        addressTextView.leftAnchor.constraint(equalTo: addressLabel.rightAnchor).isActive = true
        addressTextView.topAnchor.constraint(equalTo: addressLabel.topAnchor).isActive = true
        addressTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        addressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(clientTypeSegmentControl)
        clientTypeSegmentControl.topAnchor.constraint(equalTo: addressTextView.bottomAnchor).isActive = true
        clientTypeSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        clientTypeSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        clientTypeSegmentControl.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.darkBlue
        setUpNavigationBar()
        setUpUI()
    }
    
    private func setUpNavigationBar(){
        navigationItem.title = "Add Client"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    

    
    
}




















