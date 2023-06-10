import Foundation
import FirebaseAuth

protocol UserProviderProtocol {
    func login(user basedOn: [AnyHashable: Any], callback: @escaping (Result<UserModel, Error>) -> Void)
    func register(user basedOn: [AnyHashable: Any], callback: @escaping (Result<UserModel, Error>) -> Void)
}

final class UserProvider {
    private lazy var auth = Auth.auth()
}

extension UserProvider: UserProviderProtocol {
    func login(user basedOn: [AnyHashable : Any], callback: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard let body: NSDictionary = basedOn[Constants.ParamsKey.body] as? NSDictionary else { return }
        guard let userModel = body[Constants.ParamsKey.userModel] as? UserModel else { return }
        
        auth.signIn(withEmail: userModel.email, password: userModel.password) { result, error in
            if let error = error {
                callback(.failure(error))
            } else {
                callback(.success(userModel))
            }
        }
    }
    
    func register(user basedOn: [AnyHashable : Any], callback: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard let body: NSDictionary = basedOn[Constants.ParamsKey.body] as? NSDictionary else { return }
        guard let userModel = body[Constants.ParamsKey.userModel] as? UserModel else { return }
        
        auth.createUser(withEmail: userModel.email, password: userModel.password) { result, error in
            if let error = error {
                callback(.failure(error))
            } else {
                callback(.success(userModel))
            }
        }
    }
}
