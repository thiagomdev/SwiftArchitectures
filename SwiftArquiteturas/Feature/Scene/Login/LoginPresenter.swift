import UIKit

protocol LoginPresentationLogic {
    func presentSomething(response: Login.Something.Response)
    func presentError(_ error: Login.Something.ViewError)
}

final class LoginPresenter {
    weak var viewController: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {
    func presentSomething(response: Login.Something.Response) {
        let viewModel = Login.Something.ViewModel(user: response.user)
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentError(_ error: Login.Something.ViewError) {
        let viewError = Login.Something.ViewError(error: error.error)
        viewController?.displayViewError(viewError)
    }
}
