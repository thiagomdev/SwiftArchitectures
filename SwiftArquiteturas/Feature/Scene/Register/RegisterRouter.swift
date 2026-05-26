import UIKit

protocol RegisterRoutingLogic {
    func successRegistered()
}

final class RegisterRouter: NSObject {
    weak var viewController: UIViewController?
}

extension RegisterRouter: RegisterRoutingLogic {
    func successRegistered() {
        let register = HomeFactory.make()
        guard let viewController = viewController else { return }
        present(view: viewController, destination: register)
    }
}

extension RegisterRouter {
    private func present(view: UIViewController, destination: UIViewController) {
        destination.modalPresentationStyle = .fullScreen
        view.navigationController?.present(destination, animated: true)
    }
}
