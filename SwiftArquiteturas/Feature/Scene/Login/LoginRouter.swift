import UIKit

protocol LoginRoutingLogic {
    func openRegisterView()
    func openHomeView()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: NSObject, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
}

extension LoginRouter: LoginRoutingLogic {
    func openHomeView() {
        let home = HomeFactory.make()
        guard let viewController = viewController else { return }
        presentModalNavigation(from: viewController, destination: home)
    }
    
    func openRegisterView() {
        let register = RegisterFactory.make()
        guard let viewController = viewController else { return }
        displayNavigation(from: viewController, destination: register)
    }
}

extension LoginRouter {
    private func displayNavigation(from
        view: LoginViewController,
        destination: UIViewController
    ) {
        view.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func presentModalNavigation(from
        view: LoginViewController,
        destination: UIViewController
    ) {
        destination.modalPresentationStyle = .fullScreen
        view.navigationController?.present(destination, animated: true)
    }
}
