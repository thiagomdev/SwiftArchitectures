import UIKit

protocol LoginBusinessLogic {
    func diplayUser(with request: Login.Make.Request) async throws
}

final class LoginInteractor {
    private let worker: LoginWorkerProtocol
    private let presenter: LoginPresentationLogic
    
    init(worker: LoginWorkerProtocol, presenter: LoginPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension LoginInteractor: LoginBusinessLogic {
    func diplayUser(with request: Login.Make.Request) async throws {
        do {
            guard let user = try await worker.loginUser(basedOn: request.user) else {
                return presenter.displayError(.init(error: APIError.invalidResponse))
            }
            presenter.displaySuccess(response: .init(user: user))
        } catch {
            presenter.displayError(.init(error: error))
        }
    }
}
