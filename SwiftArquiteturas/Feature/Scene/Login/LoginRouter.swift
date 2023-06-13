import UIKit

protocol LoginRoutingLogic {
    func openRegisterView()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: NSObject, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
}

extension LoginRouter: LoginRoutingLogic {
    func openRegisterView() {
        let register = RegisterFactory.make()
        guard let viewController = viewController else { return }
        navigation(view: viewController, destination: register)
    }
}

extension LoginRouter {
    private func navigation(
        view: LoginViewController,
        destination: UIViewController
    ) {
        view.navigationController?.pushViewController(destination, animated: true)
    }
}
