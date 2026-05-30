//
//  LoginPresenterTests.swift
//  SwiftArquiteturasTests
//
//  Created by Thiago Monteiro on 5/26/26.
//

import Testing
import Foundation
@testable import SwiftArquiteturas

@Suite("🧪 Login Presenter")
struct LoginPresenterTests {
    @Test
    func displaySuccessShouldBeReturnedUserModel() {
        let (sut, loginPresenterSpy) = makeSut()
        
        sut.displaySuccess(response: .init(user: .fixture()))
        
        #expect(loginPresenterSpy.messages == [.displaySomething(.init(user: .fixture()))])
    }
    
    @Test
    func displayErrorShouldBeReturnedAnyError() {
        let (sut, loginPresenterSpy) = makeSut()
        let anyError: NSError = .init(domain: "any-error", code: -999)
        
        sut.displayError(.init(error: anyError))
        
        #expect(loginPresenterSpy.messages == [.displayViewError(.init(error: anyError))])
    }
}

extension LoginPresenterTests {
    private func makeSut() -> (sut: LoginPresenter, loginPresenterSpy: LoginPresenterSpy) {
        let loginPresenterSpy = LoginPresenterSpy()
        let sut = LoginPresenter()
        sut.viewController = loginPresenterSpy
        return (sut, loginPresenterSpy)
    }
}
