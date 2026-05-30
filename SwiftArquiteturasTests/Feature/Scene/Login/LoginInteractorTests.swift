//
//  LoginInteractorTests.swift
//  SwiftArquiteturasTests
//
//  Created by Thiago Monteiro on 5/26/26.
//

import Testing
import Foundation
@testable import SwiftArquiteturas

@Suite("🧪 Login Interactor")
struct LoginInteractorTests {
    @Test
    func diplayUserShouldBeReturnedResponseUserModel() async throws {
        let (sut, doubles) = makeSut()
        doubles.workerSpy.shouldBeReturned = .fixture()
        
        try await sut.diplayUser(with: .init(user: .fixture()))
        
        #expect(doubles.workerSpy.loginUserCalled)
        #expect(doubles.workerSpy.loginUserCount == 1)
        #expect(doubles.presenterSpy.messages == [.displaySuccess(.init(user: .fixture()))])
    }
    
    @Test
    func diplayUserShouldBeReturnedAnyError() async throws {
        let (sut, doubles) = makeSut()
        let anyError: NSError = .init(domain: "any_error", code: -999)
        let userModel: UserModel = .fixture()
        doubles.workerSpy.shouldThrow = anyError

        await #expect(throws: Login.Make.ViewError(error: anyError)) {
            try await sut.diplayUser(with: .init(user: userModel))
        }

        #expect(doubles.workerSpy.loginUserCalled)
        #expect(doubles.workerSpy.loginUserCount == 1)
        #expect(doubles.presenterSpy.messages == [.displayError(.init(error: anyError))])
    }

    @Test
    func diplayUserShouldBeReturnedInvalidResponseWhenWorkerReturnsNil() async throws {
        let (sut, doubles) = makeSut()
        let userModel: UserModel = .fixture()
        doubles.workerSpy.shouldBeReturned = nil

        await #expect(throws: Login.Make.ViewError(error: APIError.invalidResponse)) {
            try await sut.diplayUser(with: .init(user: userModel))
        }

        #expect(doubles.workerSpy.loginUserCalled)
        #expect(doubles.workerSpy.loginUserCount == 1)
        #expect(doubles.presenterSpy.messages == [.displayError(.init(error: APIError.invalidResponse))])
    }
}


extension LoginInteractorTests {
    private typealias Doubles = (
        workerSpy: LoginWorkerSpy,
        presenterSpy: LoginPresentationLogicSpy
    )
    
    private func makeSut() -> (sut: LoginInteractor, doubles: Doubles) {
        let workerSpy = LoginWorkerSpy()
        let presenterSpy = LoginPresentationLogicSpy()
        let sut = LoginInteractor(worker: workerSpy, presenter: presenterSpy)
        return (sut,(workerSpy, presenterSpy))
    }
}
