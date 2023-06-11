import UIKit

protocol HomeRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get set }
}

final class HomeRouter: NSObject {
    weak var viewController: HomeViewController?
}

extension HomeRouter: HomeRoutingLogic {
    
}

extension HomeRouter: HomeDataPassing {
    var dataStore: HomeDataStore? {
        get {
            nil
        }
        set {

        }
    }
}
