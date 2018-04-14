//
//  LoginController.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase


protocol LoginControllerDelegate {
    func didLogin()
}

class LoginController: UIViewController {
    var delegate: LoginControllerDelegate?
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
        
        if emailTextField.text != "" && passwordTextField.text != ""{
            enableLoginButton()
        }
        else{
            disableLoginButton()
        }
        
    }
    func enableLoginButton(){
        logInButton.isEnabled = true
        logInButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    func disableLoginButton(){
        logInButton.isEnabled = false
        logInButton.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
    }
    
    
    var logInButton: UIButton = {
        var button = UIButton()
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 20)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func loginButtonClicked(sender: UIButton){
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                    self.present(AlertCreator.shared.createAlertWithTitle(title: (error?.localizedDescription)!), animated: true, completion: nil)
                }
                else{
                    if Auth.auth().currentUser != nil{
                        self.dismissSelf()
                    }
                }
            })
        }
    }
    
    
    var forgotPasswordButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = UIFont(name: "GothamRounded-Book", size: 15)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func forgotPasswordButtonClicked(sender: UIButton){
        let forgotPassword = ForgotPasswordViewController()
        self.present(forgotPassword, animated: true)
    }
    
    var registerButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = UIFont(name: "GothamRounded-Book", size: 15)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func registerButtonClicked(sender: UIButton){
        let registerPage = RegisterViewController()
        self.present(registerPage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
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
        
        self.view.addSubview(logInButton)
        logInButton.topAnchor.constraint(equalTo: passwordSepertorView.bottomAnchor, constant: 50).isActive = true
        logInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(forgotPasswordButton)
        forgotPasswordButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 15).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 15).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    func dismissSelf(){
        dismiss(animated: true) {
            self.delegate?.didLogin()
        }
    }
    
    
    
    
    
    
    
}
