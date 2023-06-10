import Foundation

protocol UserBusinessProtocol {
    func loginUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void)
    func registerUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void)
}

final class UserBusiness {
    private let provider: UserProvider
    
    init(provider: UserProvider = UserProvider()) {
        self.provider = provider
    }
    
    private func displayParamsBasedOn(_ email: String, _ password: String) -> [AnyHashable: Any] {
        let userModel = UserModel(email: email, password: password)
        let params: [AnyHashable: Any] = [Constants.ParamsKey.body: [Constants.ParamsKey.userModel: userModel]]
        return params
    }
}

extension UserBusiness: UserBusinessProtocol {
    func loginUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void) {
        provider.login(user: displayParamsBasedOn(email, password)) { result in
            switch result {
            case let .success(userModel):
                callback(.success(userModel))
            case let .failure(err):
                callback(.failure(err))
            }
        }
    }
    
    func registerUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void) {
        provider.register(user: displayParamsBasedOn(email, password)) { result in
            switch result {
            case let .success(userModel):
                callback(.success(userModel))
            case let .failure(err):
                callback(.failure(err))
            }
        }
    }
}
