import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displaySomething(viewModel: Login.Make.ViewModel)
    func displayViewError(_ error: Login.Make.ViewError)
}

final class LoginViewController: UIViewController {
    // MARK: - Properties
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    // MARK: - Elements
    private lazy var containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 14
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var textFieldEmail: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.color = .darkGray
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setupConstraints()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc
    private func didTapLoginButton() {
        if let email = textFieldEmail.text,
           let password = textFieldPassword.text {
            
            displayLoggedIn(user: .init(
                email: email,
                password: password)
            )
            
            verificationFields(to: email, and: password)
        }
        clearAllFields()
    }
    
    @objc
    private func didTapRegisterButton() {
        router?.openRegisterView()
    }
    
    private func displayLoggedIn(user: UserModel) {
        let user = UserModel(email: user.email, password: user.password)
        let request = Login.Make.Request(user: user)
        interactor?.diplayUser(with: request)
    }
    
    private func clearAllFields(from text: String? = nil) {
        textFieldEmail.text = text
        textFieldPassword.text = text
    }
    
    private func verificationFields(to email: String, and password: String) {
        if email.isEmpty || password.isEmpty {
            loading.stopAnimating()
            loading.hidesWhenStopped = true
        } else {
            loading.startAnimating()
            loading.hidesWhenStopped = false
        }
    }
}

// MARK: - LoginDisplayLogic
extension LoginViewController: LoginDisplayLogic {
    func displaySomething(viewModel: Login.Make.ViewModel) {
        router?.openHomeView()
    }
    
    func displayViewError(_ error: Login.Make.ViewError) {
        let error = error.error.localizedDescription
        let alert = UIAlertController(title: "ALERTA!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
// MARK: - Configure UI
private extension LoginViewController {
    private func buildViews() {
        containerStackView.addArrangedSubview(textFieldEmail)
        containerStackView.addArrangedSubview(textFieldPassword)
        containerStackView.addArrangedSubview(loginButton)
        containerStackView.addArrangedSubview(registerButton)
        view.addSubview(containerStackView)
        view.addSubview(loading)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(
                equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
                multiplier: 3
            ),
            
            containerStackView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
                multiplier: 2
            ),
            
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalToSystemSpacingAfter: containerStackView.trailingAnchor,
                multiplier: 2
            ),
            
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .black
    }
}
