import Foundation

protocol UserManagerProtocol {
    func loginUser(basedOn email: String, password: String) async throws -> UserModel?
    func registerUser(basedOn email: String, password: String) async throws -> UserModel?
}

final class UserManager {
    private let business: UserBusinessProtocol
    
    init(business: UserBusinessProtocol) {
        self.business = business
    }
}

extension UserManager: UserManagerProtocol {
    func loginUser(basedOn email: String, password: String) async throws -> UserModel? {
        try await business.loginUser(basedOn: email, password: password)
    }
    
    func registerUser(basedOn email: String, password: String) async throws -> UserModel? {
        try await business.registerUser(basedOn: email, password: password)
    }
}
