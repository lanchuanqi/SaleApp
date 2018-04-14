//
//  RegisterViewController.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase



class RegisterViewController: UIViewController {
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
    
    var passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Password"
        label.textColor = UIColor.black
        label.font = UIFont(name: "GothamRounded-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "password"
        textField.addTarget(self, action:#selector(textFieldDidChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordSepertorView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var confirmPasswordLabel: UILabel = {
        var label = UILabel()
        label.text = "Confirm Password"
        label.textColor = UIColor.black
        label.font = UIFont(name: "GothamRounded-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var confirmPasswordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "confirm password"
        textField.addTarget(self, action:#selector(textFieldDidChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var confirmPasswordSepertorView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    @objc func textFieldDidChange(){
        if emailTextField.text != ""{
            emailSepertorView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
        else{
            emailSepertorView.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        }
        
        if passwordTextField.text != ""{
            passwordSepertorView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
        else{
            passwordSepertorView.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        }
        
        if confirmPasswordTextField.text != ""{
            confirmPasswordSepertorView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
        else{
            confirmPasswordSepertorView.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        }
        
        if emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""{
            enableRegisterButton()
        }
        else{
            disableRegisterButton()
        }
    }
    
    
    func enableRegisterButton(){
        registerButton.isEnabled = true
        registerButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    func disableRegisterButton(){
        registerButton.isEnabled = false
        registerButton.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
    }
    var registerButton: UIButton = {
        var button = UIButton()
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 20)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func registerButtonClicked(sender: UIButton){
        if self.passwordTextField.text != self.confirmPasswordTextField.text{
            self.present(AlertCreator.shared.createAlertWithTitle(title: "Passwords does not match."), animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                DispatchQueue.main.async {
                    self.present(AlertCreator.shared.createAlertWithTitle(title: (error?.localizedDescription)!), animated: true)
                }
            }
            else{
                if user != nil{
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        setUpView()
    }
    
    func setUpView(){
        
        self.view.addSubview(emailLabel)
        emailLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        emailLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
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
        
        
        self.view.addSubview(passwordLabel)
        passwordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: emailSepertorView.bottomAnchor, constant: 20).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(passwordSepertorView)
        passwordSepertorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1).isActive = true
        passwordSepertorView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        passwordSepertorView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        passwordSepertorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        self.view.addSubview(confirmPasswordLabel)
        confirmPasswordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        confirmPasswordLabel.topAnchor.constraint(equalTo: passwordSepertorView.bottomAnchor, constant: 20).isActive = true
        confirmPasswordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        confirmPasswordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 10).isActive = true
        confirmPasswordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        confirmPasswordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(confirmPasswordSepertorView)
        confirmPasswordSepertorView.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 1).isActive = true
        confirmPasswordSepertorView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        confirmPasswordSepertorView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        confirmPasswordSepertorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: confirmPasswordSepertorView.bottomAnchor, constant: 50).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(exitButton)
        exitButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        exitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
}
