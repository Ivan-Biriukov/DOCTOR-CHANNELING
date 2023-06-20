import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    // MARK: - UI Elements
    
    private let nameFieldLabel = TextFieldsLabel(labelText: "Full Name")
    private let nameTextField = ReusableTextField(style: .name)
    private let passwordFieldLabel = TextFieldsLabel(labelText: "Password")
    private let passwordTextField = ReusableTextField(style: .password)
    private let emailFieldLabel = TextFieldsLabel(labelText: "Email")
    private let emailTextField = ReusableTextField(style: .email)
    private let phoneFieldLabel = TextFieldsLabel(labelText: "Mobile Number")
    private let phoneTextField = ReusableTextField(style: .phoneNumber)
    
    private let fieldsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let signUpButton = ReusableUIButton(style: .mainBottomStyle, title: "Sign Up")
    
    private let orLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold22()
        lb.text = "OR"
        lb.textColor = .textUnavalibleGray
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let facebookButton = ReusableUIButton(style: .facebook, title: nil)
    private let googleButton = ReusableUIButton(style: .google, title: nil)
    
    private let socialButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bottomLabel : UILabel = {
        let lb = UILabel()
        lb.font = .montserratSemiBold16()
        lb.text = "Already have an account?"
        lb.textColor = .textLightBlue
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let bottomSignInButton = ReusableUIButton(style: .singInOrSingUp, title: "Sign In")
    
    private let lastLineStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightBackgroundColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        addSubviews()
        setupConstraints()
        title = "Create New Account"
        hideKeyboardWhenTappedAround()
        addButtonsTargets()
        configureTextsFields()
    }
    
    
    // MARK: - Custom Buttons Methods
    
    @objc func signUpButtonTaped() {
        
    }
    
    @objc func facebookButtonTaped() {
        
    }
    
    @objc func googleButtonTaped() {
        
    }
    
    @objc func signInButtonTaped() {
        self.navigationController?.pushViewController(WellcomeViewController(), animated: true)
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(fieldsStack)
        fieldsStack.addArrangedSubview(nameFieldLabel)
        fieldsStack.addArrangedSubview(nameTextField)
        fieldsStack.addArrangedSubview(passwordFieldLabel)
        fieldsStack.addArrangedSubview(passwordTextField)
        fieldsStack.addArrangedSubview(emailFieldLabel)
        fieldsStack.addArrangedSubview(emailTextField)
        fieldsStack.addArrangedSubview(phoneFieldLabel)
        fieldsStack.addArrangedSubview(phoneTextField)
        view.addSubview(signUpButton)
        view.addSubview(orLabel)
        view.addSubview(socialButtonsStack)
        socialButtonsStack.addArrangedSubview(facebookButton)
        socialButtonsStack.addArrangedSubview(googleButton)
        view.addSubview(lastLineStack)
        lastLineStack.addArrangedSubview(bottomLabel)
        lastLineStack.addArrangedSubview(bottomSignInButton)
    }
    
    private func addButtonsTargets() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTaped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookButtonTaped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTaped), for: .touchUpInside)
        bottomSignInButton.addTarget(self, action: #selector(signInButtonTaped), for: .touchUpInside)
    }
    
    private func configureTextsFields() {
        nameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.buttonDelegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            fieldsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            fieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            fieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            signUpButton.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 39),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 19),
            
            socialButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            socialButtonsStack.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 19),
            
            lastLineStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastLineStack.topAnchor.constraint(equalTo: socialButtonsStack.bottomAnchor, constant: 13),
        ])
    }
}

extension CreateAccountViewController: FieldeyeButtonDelegate {
    func eyeButtonTaped() {}
}
