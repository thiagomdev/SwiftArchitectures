import UIKit

protocol RegisterBusinessLogic {
    func diplayUser(with request: Register.Make.Request)
}

protocol RegisterDataStore { }

final class RegisterInteractor {
    var presenter: RegisterPresentationLogic?
    private var worker: RegisterWorker?
    
    init(worker: RegisterWorker = RegisterWorker()) {
        self.worker = worker
    }
}

extension RegisterInteractor: RegisterBusinessLogic {
    func diplayUser(with request: Register.Make.Request) {
        worker?.registerUser(basedOn: request.user, callback: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(user):
                self.presenter?.displaySuccess(response: .init(user: user))
            case let .failure(err):
                self.presenter?.displayError(.init(error: err))
            }
        })
    }
}

extension RegisterInteractor: RegisterDataStore { }
