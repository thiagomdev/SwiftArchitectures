import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {
    var name: String { get set }
}

final class HomeInteractor {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
}

extension HomeInteractor: HomeDataStore {
    var name: String {
        get {
            String()
        }
        set {
            worker?.doSomeWork()
        }
    }
}

extension HomeInteractor: HomeBusinessLogic {
    func doSomething(request: Home.Something.Request) {
        worker = HomeWorker()
        worker?.doSomeWork()
        
        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
