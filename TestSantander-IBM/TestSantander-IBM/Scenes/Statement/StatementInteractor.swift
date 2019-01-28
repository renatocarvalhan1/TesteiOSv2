//
//  StatementInteractor.swift
//  TestSantander-IBM
//
//  Created by Renato Carvalhan on 22/01/19.
//  Copyright (c) 2019 Renato Carvalhan. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

protocol StatementInteractorInput {
    func getStatements(request: StatementScene.GetStatements.Request, completionHandler: @escaping (Bool, String?) -> Void)
}

protocol StatementInteractorOutput {
    func presentStatements(response: StatementScene.GetStatements.Response)
}

protocol StatementDataSource {
    
}

protocol StatementDataDestination {
    var userAccount: UserAccount! { get set }
}

class StatementInteractor: StatementInteractorInput, StatementDataSource, StatementDataDestination {
    
    var output: StatementInteractorOutput?
    var statements: [Statement] = []
    var userAccount: UserAccount!
    var networkManager: NetworkManager!
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: Business logic
    
    func getStatements(request: StatementScene.GetStatements.Request, completionHandler: @escaping (Bool, String?) -> Void) {
        networkManager.getStatements(request: request) { (response, err) in
            if err != nil {
                completionHandler(false, err)
            } else {
                guard let statements = response?.statements else {
                    completionHandler(false, "No Data")
                    return
                }
                for statement in statements {
                    self.statements.append(statement)
                }
                
                let response = StatementScene.GetStatements.Response(statements: statements, error: nil)
                self.output?.presentStatements(response: response)
                completionHandler(true, nil)
            }
        }
    }

}