import UIKit

enum LoginFactory {
    static func make() -> UIViewController {
        let viewController = LoginViewController()
        let manager = UserManager()
        let worker = LoginWorker(manager: manager)
        let interactor = LoginInteractor(worker: worker)
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.routing = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
