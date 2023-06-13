import UIKit

protocol RegisterDisplayLogic: AnyObject {
    func displaySomething(viewModel: Register.Make.ViewModel)
    func displayViewError(_ error: Register.Make.ViewError)
}

final class RegisterViewController: UIViewController, RegisterDisplayLogic {
    var interactor: RegisterBusinessLogic?
    var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?
    
    
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
    
    private lazy var textFieldConfirmPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm password"
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(registeredUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setupConstraints()
        configureUI()
    }
    
    @objc
    private func registeredUser() {
        if let email = textFieldEmail.text,
           let password = textFieldPassword.text,
           let confirmPassword = textFieldConfirmPassword.text,
           password == confirmPassword {
            
            registered(from: .init(
                email: email,
                password: password)
            )
        }
        clearAllFields()
    }
    
    private func registered(from user: UserModel) {
        let user = UserModel(email: user.email, password: user.password)
        let request = Register.Make.Request(user: user)
        interactor?.diplayUser(with: request)
    }
    
    private func clearAllFields(from text: String? = nil) {
        textFieldEmail.text = text
        textFieldPassword.text = text
        textFieldConfirmPassword.text = text
    }
}

extension RegisterViewController {
    func displaySomething(viewModel: Register.Make.ViewModel) {
        router?.successRegistered()
    }
    
    func displayViewError(_ error: Register.Make.ViewError) {
        let error = error.error.localizedDescription
        let alert = UIAlertController(title: "ALERTA!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Configure UI
extension RegisterViewController {
    private func buildViews() {
        containerStackView.addArrangedSubview(textFieldEmail)
        containerStackView.addArrangedSubview(textFieldPassword)
        containerStackView.addArrangedSubview(textFieldConfirmPassword)
        containerStackView.addArrangedSubview(registerButton)
        view.addSubview(containerStackView)
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
            )
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
