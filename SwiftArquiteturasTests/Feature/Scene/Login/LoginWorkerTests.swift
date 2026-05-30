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
