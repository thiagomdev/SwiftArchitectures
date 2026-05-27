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
    func loginUserShouldBeReturnedValidUserModelInformation() async throws {
        let (sut, managerSpy) = makeSut()
        let userModel: UserModel = .fixture()
        managerSpy.shouldBeReturned = userModel
        
        let expected = try await #require(sut.loginUser(basedOn: userModel))
        
        #expect(managerSpy.loginUserCalled)
        #expect(managerSpy.loginUserCount == 1)
        #expect(managerSpy.shouldBeReturned == expected)
    }
    
    @Test
    func loginUserShouldNotReturnedValidUserModelInformation() async throws {
        let (sut, managerSpy) = makeSut()
        let userModel: UserModel = .fixture()

        managerSpy.shouldThrow = APIError.invalidResponse

        await #expect(throws: APIError.self) {
            _ = try await sut.loginUser(basedOn: userModel)
        }
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

    var shouldBeReturned: UserModel?
    var shouldThrow: Error?

    private(set) var expectedEmail: String?
    private(set) var expectedPassword: String?

    private(set) var loginUserCalled: Bool = false
    private(set) var loginUserCount: Int = 0

    func loginUser(basedOn email: String, password: String) async throws -> UserModel? {
        loginUserCalled = true
        loginUserCount += 1
        expectedEmail = email
        expectedPassword = password
        if let shouldThrow { throw shouldThrow }
        return shouldBeReturned
    }

    func registerUser(basedOn email: String, password: String) async throws -> UserModel? {
        expectedEmail = email
        expectedPassword = password
        if let shouldThrow { throw shouldThrow }
        return shouldBeReturned
    }
}
