import UIKit

protocol LoginBusinessLogic {
    func diplayUser(with request: Login.Make.Request)
}

protocol LoginDataStore { }

final class LoginInteractor {
    var presenter: LoginPresentationLogic?
    private var worker: LoginWorker?
    
    init(worker: LoginWorker =  LoginWorker()) {
        self.worker = worker
    }
}

extension LoginInteractor: LoginBusinessLogic {
    func diplayUser(with request: Login.Make.Request) {
        worker?.loginUser(basedOn: request.user, callback: { [weak self] result in
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

extension LoginInteractor: LoginDataStore { }
