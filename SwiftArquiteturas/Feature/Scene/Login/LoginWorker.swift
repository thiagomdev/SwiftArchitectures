import UIKit

protocol LoginWorkerProtocol {
    func loginUser(basedOn user: UserModel) async throws -> UserModel?
}

final class LoginWorker {
    private let manager: UserManagerProtocol
    
    init(manager: UserManagerProtocol) {
        self.manager = manager
    }
}

extension LoginWorker: LoginWorkerProtocol {
    func loginUser(basedOn user: UserModel) async throws -> UserModel? {
        try await manager.loginUser(basedOn: user.email, password: user.password)
    }
}
