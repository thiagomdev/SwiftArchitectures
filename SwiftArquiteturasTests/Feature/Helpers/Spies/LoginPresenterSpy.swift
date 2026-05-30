//
//  LoginPresenterSpy.swift
//  SwiftArquiteturas
//
//  Created by Thiago Monteiro on 5/30/26.
//
@testable import SwiftArquiteturas
final class LoginPresenterSpy: LoginDisplayLogic {
    enum Message:Equatable {
        case displaySomething(Login.Make.ViewModel)
        case displayViewError(Login.Make.ViewError)
    }
    
    private(set) var messages = [Message]()
    
    func displaySomething(viewModel: Login.Make.ViewModel) {
        messages.append(.displaySomething(viewModel))
    }
    
    func displayViewError(_ error: Login.Make.ViewError) {
        messages.append(.displayViewError(error))
    }
}
