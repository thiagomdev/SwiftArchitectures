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
    
    private lazy var textFieldEmail = makeTextField("Email")
    private lazy var textFieldPassword = makeTextField("Password", securityEntry: true)
    private lazy var textFieldConfirmPassword = makeTextField("Confirm password", securityEntry: true)
 
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(registeredUser), for: .touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setupConstraints()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loading.stopAnimating()
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
            
            verificationFields(to: email, to: password, and: confirmPassword)
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
    
    private func verificationFields(to email: String, to password: String, and confirmPassword: String) {
        if email.isEmpty || password.isEmpty || password != confirmPassword {
            loading.stopAnimating()
            loading.hidesWhenStopped = true
        } else {
            loading.startAnimating()
            loading.hidesWhenStopped = false
        }
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
private extension RegisterViewController {
    private func buildViews() {
        containerStackView.addArrangedSubview(textFieldEmail)
        containerStackView.addArrangedSubview(textFieldPassword)
        containerStackView.addArrangedSubview(textFieldConfirmPassword)
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

private extension RegisterViewController {
    private func makeTextField(_ placeholder: String, securityEntry: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = securityEntry
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
