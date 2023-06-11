import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displaySomething(viewModel: Home.Something.ViewModel)
}

final class HomeViewController: UIViewController {
    //MARK: - Properties
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    //MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doSomething()
    }
    
    //MARK: - Methods
    private func doSomething() {
        let request = Home.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    //MARK: - Selectors
}

//MARK: - HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displaySomething(viewModel: Home.Something.ViewModel) {
        
    }
}
