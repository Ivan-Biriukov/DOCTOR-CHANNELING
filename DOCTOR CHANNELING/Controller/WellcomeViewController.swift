import UIKit

class WellcomeViewController: UIViewController, UITextFieldDelegate, FieldeyeButtonDelegate {
    
    // MARK: - UI Elements
    
    private let mainLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold26()
        lb.text = "Sign in"
        lb.textColor = .black
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let descLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular18()
        lb.text = "Please enter your account name and password, for log in."
        lb.textColor = .black
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let emailLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular22()
        lb.text = "Email"
        lb.textColor = .black
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    private lazy var fieldEyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.addTarget(self, action: #selector(eyeButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btn
    }()
    
    private let emailTextField = ReusableTextField(style: .email)
    private let passwordTextField = ReusableTextField(style: .password)
    
    private let passwordLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular22()
        lb.text = "Password"
        lb.textColor = .black
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var recoverPasswordButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Forget Password", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
        btn.titleLabel?.font = .averiaRegular18()
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(recoverPasswordTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let signInButton = ReusableUIButton(style: .mainBottomStyle, title: "Sign In")
    
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
    
    private let bottomLabel : UILabel = {
        let lb = UILabel()
        lb.font = .montserratSemiBold16()
        lb.text = "Don’t have an account?"
        lb.textColor = .textLightBlue
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let bottomSignUpButton = ReusableUIButton(style: .singInOrSingUp, title: "Sign Up")
    
    private let lastLineStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let topLabelStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let fieldsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 22
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let socialButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .lightBackgroundColor
        onboardingNavBar(titleText: "Welcome")
        self.navigationItem.setHidesBackButton(true, animated: true)
        addButtonsTargets()
        setupConstraints()
        configureTextFields()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Custom Buttons Methods
    
    @objc func eyeButtonTaped() {}
    
    @objc func recoverPasswordTaped() {
        recoverPasswordButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.recoverPasswordButton.alpha = 1.0
        }
    }
    
    @objc func signInButtonTaped() {
        print("signInButtonTaped")
    }
    
    @objc func facebookButtonTaped() {
        print("facebookButtonTaped")
    }
    
    @objc func googleButtonTaped() {
        print("googleButtonTaped")
    }
    
    @objc func signUpButtonTaped() {
        print("signUpButtonTaped")
        presentNewVC(vcToPresent: CreateAccountViewController())
    }

    // MARK: - Configure UI

    private func addSubviews() {
        view.addSubview(topLabelStack)
        topLabelStack.addArrangedSubview(mainLabel)
        topLabelStack.addArrangedSubview(descLabel)
        view.addSubview(fieldsStack)
        fieldsStack.addArrangedSubview(emailLabel)
        fieldsStack.addArrangedSubview(emailTextField)
        fieldsStack.addArrangedSubview(passwordLabel)
        fieldsStack.addArrangedSubview(passwordTextField)
        view.addSubview(recoverPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(orLabel)
        view.addSubview(socialButtonsStack)
        socialButtonsStack.addArrangedSubview(facebookButton)
        socialButtonsStack.addArrangedSubview(googleButton)
        view.addSubview(lastLineStack)
        lastLineStack.addArrangedSubview(bottomLabel)
        lastLineStack.addArrangedSubview(bottomSignUpButton)
    }
    
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.buttonDelegate = self
    }
    
    private func addButtonsTargets() {
        signInButton.addTarget(self, action: #selector(signInButtonTaped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookButtonTaped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTaped), for: .touchUpInside)
        bottomSignUpButton.addTarget(self, action: #selector(signUpButtonTaped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topLabelStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            topLabelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            topLabelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            fieldsStack.topAnchor.constraint(equalTo: topLabelStack.bottomAnchor, constant: 62),
            fieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            fieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),

            recoverPasswordButton.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 16),
            recoverPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),

            signInButton .topAnchor.constraint(equalTo: recoverPasswordButton.bottomAnchor, constant: 35),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),

            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 19),

            socialButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            socialButtonsStack.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 19),

            lastLineStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastLineStack.topAnchor.constraint(equalTo: socialButtonsStack.bottomAnchor, constant: 13),
        ])
    }
}
