import UIKit

protocol RegisterBusinessLogic {
    func diplayUser(with request: Register.Make.Request) async throws
}

final class RegisterInteractor {
    private let presenter: RegisterPresentationLogic
    private let worker: RegisterWorkerProtocol
    
    init(worker: RegisterWorkerProtocol, presenter: RegisterPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension RegisterInteractor: RegisterBusinessLogic {
    func diplayUser(with request: Register.Make.Request) async throws {
        guard let user = try await worker.registerUser(basedOn: request.user) else {
            return presenter.displayError(.init(error: APIError.invalidResponse))
        }
        presenter.displaySuccess(response: .init(user: user))
    }
}
