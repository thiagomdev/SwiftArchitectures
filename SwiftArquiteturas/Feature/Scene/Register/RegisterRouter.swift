import UIKit

protocol RegisterRoutingLogic {
    func dismiss()
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol RegisterDataPassing {
    var dataStore: RegisterDataStore? { get }
}

final class RegisterRouter: NSObject {
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    
    private func navigation(view: RegisterViewController, destination: UIViewController) {
        view.dismiss(animated: true)
    }
}

extension RegisterRouter: RegisterDataPassing {
    
}

extension RegisterRouter: RegisterRoutingLogic {
    func dismiss() {
        let login = LoginViewController()
        guard let viewController = viewController else { return }
        navigation(view: viewController, destination: login)
    }
}
