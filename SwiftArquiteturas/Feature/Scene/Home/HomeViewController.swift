import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displaySomething(viewModel: Home.Something.ViewModel)
}

final class HomeViewController: UIViewController {
    //MARK: - Properties
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to HomeView."
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemBrown
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setpConstraints()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

extension HomeViewController {
    private func buildViews() {
        view.addSubview(welcomeLabel)
    }
    
    private func setpConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .black
    }
}
