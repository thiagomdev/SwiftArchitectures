import UIKit

enum LoginFactory {
    static func make() -> UIViewController {
        let viewController = LoginViewController()
        let userBusiness = UserBusiness()
        let manager = UserManager(business: userBusiness)
        let worker = LoginWorker(manager: manager)
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(worker: worker, presenter: presenter)
        let router = LoginRouter()
        
        viewController.interactor = interactor
        viewController.routing = router
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
