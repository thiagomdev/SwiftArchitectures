//
//  LoginWorkerSpy.swift
//  SwiftArquiteturas
//
//  Created by Thiago Monteiro on 5/30/26.
//

@testable import SwiftArquiteturas
final class LoginWorkerSpy: LoginWorkerProtocol {
    var shouldBeReturned: UserModel?
    var shouldThrow: Error?

    private(set) var loginUserCalled: Bool = false
    private(set) var loginUserCount: Int = 0

    func loginUser(basedOn user: UserModel) async throws -> UserModel? {
        loginUserCalled = true
        loginUserCount += 1
        if let shouldThrow { throw shouldThrow }
        return shouldBeReturned
    }
}
