import UIKit

protocol RegisterPresentationLogic {
    func displaySuccess(response: Register.Make.Response)
    func displayError(_ error: Register.Make.ViewError)
}

final class RegisterPresenter {
    weak var viewController: RegisterDisplayLogic?
}

extension RegisterPresenter: RegisterPresentationLogic {
    func displaySuccess(response: Register.Make.Response) {
        let viewModel = Register.Make.ViewModel(user: response.user)
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func displayError(_ error: Register.Make.ViewError) {
        let viewError = Register.Make.ViewError(error: error.error)
        viewController?.displayViewError(viewError)
    }
}
