import UIKit

protocol LoginWorkerProtocol {
    func loginUser(basedOn user: UserModel, callback: @escaping (Result<UserModel, Error>) -> Void)
}

final class LoginWorker {
    private let manager: UserManager
    
    init(manager: UserManager = UserManager(business: UserBusiness())) {
        self.manager = manager
    }
}

extension LoginWorker: LoginWorkerProtocol {
    func loginUser(basedOn user: UserModel, callback: @escaping (Result<UserModel, Error>) -> Void) {
        manager.loginUser(basedOn: user.email, password: user.password) { result in
            switch result {
            case let .success(user):
                callback(.success(user))
            case let .failure(err):
                callback(.failure(err))
            }
        }
    }
}
