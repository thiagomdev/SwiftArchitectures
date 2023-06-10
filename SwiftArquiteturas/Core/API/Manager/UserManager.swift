import Foundation

protocol UserManagerProtocol {
    func loginUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void)
    func registerUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void)
}

final class UserManager {
    private let business: UserBusiness
    
    init(business: UserBusiness = UserBusiness()) {
        self.business = business
    }
}

extension UserManager: UserManagerProtocol {
    func loginUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void) {
        business.loginUser(basedOn: email, password: password) { result in
            switch result {
            case let .success(userModel):
                callback(.success(userModel))
            case let .failure(err):
                callback(.failure(err))
            }
        }
    }
    
    func registerUser(basedOn email: String, password: String, callback: @escaping (Result<UserModel, Error>) -> Void) {
        business.registerUser(basedOn: email, password: password) { result in
            switch result {
            case let .success(userModel):
                callback(.success(userModel))
            case let .failure(err):
                callback(.failure(err))
            }
        }
    }
}
