import Foundation
import FirebaseAuth

protocol UserProviderProtocol {
    func login(user basedOn: [AnyHashable: Any]) async throws -> UserModel?
    func register(user basedOn: [AnyHashable: Any]) async throws -> UserModel?
}

final class UserProvider {
    private lazy var auth = Auth.auth()
}

extension UserProvider: UserProviderProtocol {
    func login(user basedOn: [AnyHashable : Any]) async throws -> UserModel? {
        guard let body: NSDictionary = basedOn[Constants.ParamsKey.body] as? NSDictionary else { return nil }
        guard let userModel = body[Constants.ParamsKey.userModel] as? UserModel else { return nil }
        
        try await auth.signIn(withEmail: userModel.email, password: userModel.password)
        return userModel
    }
    
    func register(user basedOn: [AnyHashable : Any]) async throws -> UserModel? {
        guard let body: NSDictionary = basedOn[Constants.ParamsKey.body] as? NSDictionary else { return nil }
        guard let userModel = body[Constants.ParamsKey.userModel] as? UserModel else { return nil }
        
        try await auth.createUser(withEmail: userModel.email, password: userModel.password)
        return userModel
    }
}
