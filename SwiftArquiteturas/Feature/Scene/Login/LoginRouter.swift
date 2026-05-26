import UIKit

protocol LoginRoutingLogic {
    func openRegisterView()
    func openHomeView()
}

final class LoginRouter: NSObject, LoginRoutingLogic {
    weak var viewController: UIViewController?
}
extension LoginRouter {
    private func push(from view: UIViewController, destination: UIViewController) {
        DispatchQueue.main.async {
            view.navigationController?.pushViewController(destination, animated: true)
        }
    }
}

extension LoginRouter {
    func openHomeView() {
        let home = HomeFactory.make()
        guard let viewController = viewController else { return }
        push(from: viewController, destination: home)
    }
}

extension LoginRouter {
    func openRegisterView() {
        let register = RegisterFactory.make()
        guard let viewController = viewController else { return }
        push(from: viewController, destination: register)
    }
}
