//
//  LoginConfigurator.swift
//  TestSantander-IBM
//
//  Created by Renato Carvalhan on 22/01/19.
//  Copyright (c) 2019 Renato Carvalhan. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension LoginInteractor: LoginViewControllerOutput, LoginRouterDataSource, LoginRouterDataDestination {
    
}

extension LoginPresenter: LoginInteractorOutput {
}

class LoginConfigurator {
    // MARK: Object lifecycle
    
    static let sharedInstance = LoginConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: LoginViewController) {
        
        let presenter = LoginPresenter()
        presenter.output = viewController
        
        let interactor = LoginInteractor(networkManager: NetworkManager())
        interactor.output = presenter
        
        let router = LoginRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)
        
        viewController.output = interactor
        viewController.router = router
    }
}
