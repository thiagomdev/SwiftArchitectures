import UIKit

protocol RegisterRoutingLogic {
    func successRegistered()
}

protocol RegisterDataPassing {
    var dataStore: RegisterDataStore? { get }
}

final class RegisterRouter: NSObject {
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
}

extension RegisterRouter: RegisterDataPassing { }

extension RegisterRouter: RegisterRoutingLogic {
    func successRegistered() {
        let register = HomeFactory.make()
        guard let viewController = viewController else { return }
        navigation(view: viewController, destination: register)
    }
}

extension RegisterRouter {
    private func navigation(
        view: RegisterViewController,
        destination: UIViewController
    ) {
//        destination.modalPresentationStyle = .fullScreen
        view.navigationController?.present(destination, animated: true)
    }
}
