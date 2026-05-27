import UIKit

enum RegisterFactory {
    static func make() -> UIViewController {
        let viewController = RegisterViewController()
        let userBusiness = UserBusiness()
        let manager = UserManager(business: userBusiness)
        let worker = RegisterWorker(manager: manager)
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor(worker: worker, presenter: presenter)
        let router = RegisterRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
