//
//  LoginViewController.swift
//  TestSantander-IBM
//
//  Created by Renato Carvalhan on 22/01/19.
//  Copyright (c) 2019 Renato Carvalhan. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

protocol LoginViewControllerInput {
    
}

protocol LoginViewControllerOutput {
    func postLogin(request: LoginScene.Login.Request, completionHandler: @escaping (Bool, String?) -> Void)
}

class LoginViewController: UIViewController, LoginViewControllerInput {
    
    var output: LoginViewControllerOutput?
    var router: LoginRouter?
    
    @IBOutlet weak var userTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LoginConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Requests
    
    @IBAction func send() {
        guard let user = userTextField.text , let password = passwordTextField.text else { return }
        
        if verifyIfValidFields() {
            let request = LoginScene.Login.Request(userAccount: user, password: password)
            loadingAlert()
            output?.postLogin(request: request, completionHandler: { (succeed, err) in
                if succeed {
                    DispatchQueue.main.async {
                        self.dismiss(animated: false, completion: {
                            self.router?.navigateLoginToStatementsScene()
                        })
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: false, completion: {
                            self.showDefaultAlert(title: "Ops!", message: err!)
                        })
                    }
                }
            })
        }
    }
    
    // MARK: Display logic
    
    private func verifyIfValidFields() -> Bool {
        guard let user = userTextField.text , let password = passwordTextField.text else {
            return false
        }
        
        if user.isNumeric && !user.isValidCPF() {
            showDefaultAlert(title: "Ops!", message: "Usuário informado é inválido.")
            return false
            
        } else if !user.isValidEmail() {
            showDefaultAlert(title: "Ops!", message: "Usuário informado é inválido.")
            return false
        }
        
        if !password.isValidPassword() {
            showDefaultAlert(title: "Ops!", message: "Senha informada é inválida.")
            return false
        }
        
        return true
    }
}

//This should be on configurator but for some reason storyboard doesn't detect ViewController's name if placed there
extension LoginViewController: LoginPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(for: segue)
    }
}
