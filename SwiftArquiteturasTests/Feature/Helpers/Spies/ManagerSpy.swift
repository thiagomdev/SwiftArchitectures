//
//  ManagerSpy.swift
//  SwiftArquiteturas
//
//  Created by Thiago Monteiro on 5/30/26.
//

@testable import SwiftArquiteturas
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
