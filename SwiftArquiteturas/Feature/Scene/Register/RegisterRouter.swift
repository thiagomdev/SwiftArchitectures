import UIKit

protocol RegisterRoutingLogic {
    func successRegistered()
}

final class RegisterRouter: NSObject {
    weak var viewController: UIViewController?
}

extension RegisterRouter: RegisterRoutingLogic {
    func successRegistered() {
        Task {
            let register = await HomeFactory.make()
            guard let viewController = viewController else { return }
            await present(view: viewController, destination: register)
        }
    }
}

extension RegisterRouter {
    @MainActor
    private func present(view: UIViewController, destination: UIViewController) {
        destination.modalPresentationStyle = .fullScreen
        view.navigationController?.present(destination, animated: true)
    }
}
