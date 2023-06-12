import UIKit

protocol RegisterWorkerProtocol {
    func registerUser(basedOn user: UserModel, callback: @escaping (Result<UserModel, Error>) -> Void)
}

final class RegisterWorker {
    private let manager: UserManager
    
    init(manager: UserManager = UserManager(business: UserBusiness())) {
        self.manager = manager
    }
}

extension RegisterWorker: RegisterWorkerProtocol {
    func registerUser(basedOn user: UserModel, callback: @escaping (Result<UserModel, Error>) -> Void) {
        manager.registerUser(basedOn: user.email, password: user.password) { result in
            switch result {
            case let .success(user):
                callback(.success(user))
            case let .failure(err):
                callback(.failure(err))
            }
        }
    }
}
