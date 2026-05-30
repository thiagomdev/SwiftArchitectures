//
//  Fixture.swift
//  SwiftArquiteturas
//
//  Created by Thiago Monteiro on 5/30/26.
//

@testable import SwiftArquiteturas
extension UserModel {
    static func fixture(email: String = "email@gmail.com", password: String = "password") -> Self {
        return .init(email: email, password: password)
    }
}
