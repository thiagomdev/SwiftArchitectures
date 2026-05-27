import UIKit

protocol RegisterWorkerProtocol {
    func registerUser(basedOn user: UserModel) async throws -> UserModel?
}

final class RegisterWorker {
    private let manager: UserManagerProtocol
    
    init(manager: UserManagerProtocol) {
        self.manager = manager
    }
}

extension RegisterWorker: RegisterWorkerProtocol {
    func registerUser(basedOn user: UserModel) async throws -> UserModel? {
        try await manager.registerUser(basedOn: user.email, password: user.password)
    }
}
