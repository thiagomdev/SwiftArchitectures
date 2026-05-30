//
//  LoginPresentationLogicSpy.swift
//  SwiftArquiteturas
//
//  Created by Thiago Monteiro on 5/30/26.
//

@testable import SwiftArquiteturas
final class LoginPresentationLogicSpy: LoginPresentationLogic {
    enum Message: Equatable {
        case displaySuccess(Login.Make.Response)
        case displayError(Login.Make.ViewError)
    }
    
    private(set) var messages = [Message]()
    
    func displaySuccess(response: Login.Make.Response) {
        messages.append(.displaySuccess(response))
    }
    
    func displayError(_ error: Login.Make.ViewError) {
        messages.append(.displayError(error))
    }
}
