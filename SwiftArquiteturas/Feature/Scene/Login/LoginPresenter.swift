import UIKit

protocol LoginPresentationLogic {
    func displaySuccess(response: Login.Make.Response)
    func displayError(_ error: Login.Make.ViewError)
}

final class LoginPresenter {
    weak var viewController: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {
    func displaySuccess(response: Login.Make.Response) {
        let viewModel = Login.Make.ViewModel(user: response.user)
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func displayError(_ error: Login.Make.ViewError) {
        let viewError = Login.Make.ViewError(error: error.error)
        viewController?.displayViewError(viewError)
    }
}
