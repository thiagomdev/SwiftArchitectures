import UIKit

protocol LoginRoutingLogic {
    func openHomeView()
    func openRegisterView()
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: NSObject, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    private func navigation(view: LoginViewController, destination: UIViewController) {
        view.navigationController?.pushViewController(destination, animated: true)
    }
}

extension LoginRouter: LoginRoutingLogic {
    func openHomeView() {
        
    }
    
    func openRegisterView() {
        let register = RegisterViewController()
        navigation(view: viewController!, destination: register)
    }
}
