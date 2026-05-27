import Foundation

protocol UserBusinessProtocol {
    func loginUser(basedOn email: String, password: String) async throws -> UserModel?
    func registerUser(basedOn email: String, password: String) async throws -> UserModel?
}

final class UserBusiness {
    private let provider: UserProvider
    
    init(provider: UserProvider = UserProvider()) {
        self.provider = provider
    }
}

extension UserBusiness: UserBusinessProtocol {
    func loginUser(basedOn email: String, password: String) async throws -> UserModel? {
        try await provider.login(user: displayParamsBasedOn(email, password))
    }
    
    func registerUser(basedOn email: String, password: String) async throws -> UserModel? {
        try await provider.register(user: displayParamsBasedOn(email, password))
    }
}

extension UserBusiness {
    private func displayParamsBasedOn(_ email: String, _ password: String) -> [AnyHashable: Any] {
        let userModel = UserModel(email: email, password: password)
        let params: [AnyHashable: Any] = [Constants.ParamsKey.body: [Constants.ParamsKey.userModel: userModel]]
        return params
    }
}
