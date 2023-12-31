import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

class CreateAccountViewController: UIViewController {
    
    let db = Firestore.firestore()

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
        view.backgroundColor = .systemBackground
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
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Got It", style: .cancel)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                } else {
                    self.saveUserDataFromFieldsRegister()
                    self.present(self.setupMainInterfaceNavController(), animated: true)
                }
            }
        }
    }
    
    @objc func facebookButtonTaped() {
        
    }
    
    @objc func googleButtonTaped() {
    //    saveUserDataFromSocialLogin()
        SocialButtonManager.logInUsingGoogle(currentVC: self, db: self.db)
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

// MARK: - Delegates Methods

extension CreateAccountViewController: FieldeyeButtonDelegate , UITextFieldDelegate {
    
    func eyeButtonTaped() {}
    
}

// MARK: - FireBase Save User Data

extension CreateAccountViewController {
    
    private func saveUserDataFromFieldsRegister() {
        if let currentUser = Auth.auth().currentUser, let password = passwordTextField.text, let userName = nameTextField.text, let phoneNumber = phoneTextField.text, let userEmail = emailTextField.text {
            
            db.collection("users: \(currentUser.uid)").addDocument(data: [
                "userID" : currentUser.uid,
                "userName" : userName,
                "userEmail" : userEmail,
                "userPassword" : password,
                "userPhoneNumber" : phoneNumber,
                "userAvatarURL" : URL(string: "https://www.flaticon.com/free-icon/who_5726297?term=user+avatar&page=4&position=45&origin=tag&related_id=5726297")!.absoluteString
            ])
        }
    }
    
    
//    private func saveUserDataFromSocialLogin() {
//        if let currentUser = Auth.auth().currentUser, let userName =  currentUser.displayName, let userEmail = currentUser.email, let phoneNumber = currentUser.phoneNumber, let userAvatar = currentUser.photoURL {
//            db.collection("users").addDocument(data: [
//                "userID" : currentUser.providerID,
//                "userName" : userName,
//                "userEmail" : userEmail,
//                "userPassword" : nil,
//                "userPhoneNumber" : phoneNumber,
//            ])
//        }
//    }
}
