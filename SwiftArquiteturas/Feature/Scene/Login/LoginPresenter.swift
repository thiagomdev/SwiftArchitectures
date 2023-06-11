import UIKit

protocol LoginPresentationLogic {
    func displaySuccess(response: Login.Something.Response)
    func displayError(_ error: Login.Something.ViewError)
}

final class LoginPresenter {
    weak var viewController: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {
    func displaySuccess(response: Login.Something.Response) {
        let viewModel = Login.Something.ViewModel(user: response.user)
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func displayError(_ error: Login.Something.ViewError) {
        let viewError = Login.Something.ViewError(error: error.error)
        viewController?.displayViewError(viewError)
    }
}
