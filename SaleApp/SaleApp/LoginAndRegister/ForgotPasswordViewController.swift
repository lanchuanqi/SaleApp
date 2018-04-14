//
//  ForgotPasswordViewController.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase


class ForgotPasswordViewController: UIViewController {
    var exitButton: UIButton = {
        var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "exit"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func exitButtonClicked(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    var messageLabel: UILabel = {
        var label = UILabel()
        label.text = "Enter you email address below and we will send you instructions to reset you password."
        label.font = UIFont(name: "GothamRounded-Book", size: 12)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailLabel: UILabel = {
        var label = UILabel()
        label.text = "Email"
        label.textColor = UIColor.black
        label.font = UIFont(name: "GothamRounded-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "example@example.com"
        textField.addTarget(self, action:#selector(textFieldDidChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var emailSepertorView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func textFieldDidChange(){
        if self.emailTextField.text != ""{
            self.emailSepertorView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            enableResetButton()
        }
        else{
            self.emailSepertorView.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
            disableResetButton()
        }
    }
    
    func enableResetButton(){
        resetButton.isEnabled = true
        resetButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    func disableResetButton(){
        resetButton.isEnabled = false
        resetButton.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
    }
    
    var resetButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func resetButtonClicked(sender: UIButton){
        if let email = emailTextField.text{
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if error != nil{
                    self.present(AlertCreator.shared.createAlertWithTitle(title: (error?.localizedDescription)!), animated: true)
                }
                else{
                    self.present(AlertCreator.shared.createSuccessAlertWithTitle(title: "Please check your email address and reset your password!"), animated: true, completion: nil)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor.white
        setUpView()
    }
    
    func setUpView(){
        self.view.addSubview(messageLabel)
        messageLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(emailSepertorView)
        emailSepertorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 1).isActive = true
        emailSepertorView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        emailSepertorView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        emailSepertorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(resetButton)
        resetButton.topAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        resetButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(exitButton)
        exitButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        exitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
}
