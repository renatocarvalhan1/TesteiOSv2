//
//  StatementConfigurator.swift
//  TestSantander-IBM
//
//  Created by Renato Carvalhan on 22/01/19.
//  Copyright (c) 2019 Renato Carvalhan. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension StatementInteractor: StatementViewControllerOutput, StatementRouterDataSource, StatementRouterDataDestination {
}

extension StatementPresenter: StatementInteractorOutput {
}

class StatementConfigurator {
    // MARK: Object lifecycle
    
    static let sharedInstance = StatementConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: StatementViewController) {
        
        let presenter = StatementPresenter()
        presenter.output = viewController
        
        let interactor = StatementInteractor(networkManager: NetworkManager())
        interactor.output = presenter
        
        let router = StatementRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)
        
        viewController.output = interactor
        viewController.router = router
    }
}
