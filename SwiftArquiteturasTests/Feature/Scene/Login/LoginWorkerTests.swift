//
//  LoginWorkerTests.swift
//  SwiftArquiteturasTests
//
//  Created by Thiago Monteiro on 5/26/26.
//

import Testing
import Foundation
@testable import SwiftArquiteturas

@Suite("🧪 Login Worker")
struct LoginWorkerTests {
    @Test
    func loginUserShouldBeReturnedValidUserModelInformation() {
        let (sut, managerSpy) = makeSut()
        var userModel: UserModel = .fixture()
        managerSpy.shouldBeReturned = .success(userModel)
        
        sut.loginUser(basedOn: userModel) { result in
            switch result {
            case let .success(model):
                userModel = model
            case let .failure(anyError):
                Issue.record("Expected .success, got \(anyError)")
            }
        }
        
        #expect(managerSpy.loginUserCalled)
        #expect(managerSpy.loginUserCount == 1)
        #expect(managerSpy.expectedEmail == userModel.email)
        #expect(managerSpy.expectedPassword == userModel.password)
    }
    
    @Test
    func loginUserShouldNotReturnedValidUserModelInformation() {
        let (sut, managerSpy) = makeSut()
        let userModel: UserModel = .fixture()
        var anyError: NSError = .init(domain: "any-error", code: -999)
        
        managerSpy.shouldBeReturned = .failure(anyError)
        
        sut.loginUser(basedOn: .fixture()) { result in
            switch result {
            case let .success(model):
                Issue.record("Expected .failure, got \(model)")
            case let .failure(err):
                anyError = err as NSError
            }
        }
        
        #expect(managerSpy.loginUserCalled)
        #expect(managerSpy.loginUserCount == 1)
        #expect(managerSpy.expectedEmail == userModel.email)
        #expect(managerSpy.expectedPassword == userModel.password)
    }
}

extension LoginWorkerTests {
    private func makeSut() -> (sut: LoginWorker, managerSpy: ManagerSpy) {
        let managerSpy = ManagerSpy()
        let sut = LoginWorker(manager: managerSpy)
        return (sut, managerSpy)
    }
}

final class ManagerSpy: UserManagerProtocol {
    var shouldBeReturned: (Result<UserModel, any Error>)?
    
    private(set) var expectedEmail: String?
    private(set) var expectedPassword: String?
    
    private(set) var loginUserCalled: Bool = false
    private(set) var loginUserCount: Int = 0
    
    func loginUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, any Error>) -> Void) {
        loginUserCalled = true
        loginUserCount += 1
        expectedEmail = email
        expectedPassword = password
        if let shouldBeReturned {
            callback(shouldBeReturned)
        }
    }
    
    func registerUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, any Error>) -> Void) {
        expectedEmail = email
        expectedPassword = password
    }
}
