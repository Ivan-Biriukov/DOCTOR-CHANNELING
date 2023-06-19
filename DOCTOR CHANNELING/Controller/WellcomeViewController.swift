import UIKit

class WellcomeViewController: UIViewController {
    
    private var isPasswordHidden : Bool = true
    
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
        lb.text = "Please enter your account name and password, for log in"
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
    
    private let emailTextField : UITextField = {
        let field = UITextField()
        field.backgroundColor = .lightGrayBackgroundColor
        field.keyboardType = .emailAddress
        field.attributedPlaceholder = NSAttributedString (
                    string: "Enter Your Email",
                    attributes: [
                        NSAttributedString.Key.foregroundColor: UIColor.textUnavalibleGray,
                        NSAttributedString.Key.font: UIFont.averiaRegular18() ?? UIFont.systemFont(ofSize: 18)
                    ]
         )
        field.font = .averiaRegular18()
        field.textColor = .black
        field.textAlignment = .left
        field.tintColor = .black
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var fieldEyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.addTarget(self, action: #selector(eyeButtonTaped), for: .touchUpInside)
        return btn
    }()
    
    private let passwordTextField : UITextField = {
        let field = UITextField()
        field.backgroundColor = .lightGrayBackgroundColor
        field.keyboardType = .default
        field.attributedPlaceholder = NSAttributedString (
                    string: "Enter Your Password",
                    attributes: [
                        NSAttributedString.Key.foregroundColor: UIColor.textUnavalibleGray,
                        NSAttributedString.Key.font: UIFont.averiaRegular18() ?? UIFont.systemFont(ofSize: 18)
                    ]
         )
        field.font = .averiaRegular18()
        field.textColor = .black
        field.textAlignment = .left
        field.tintColor = .textLightBlue
    
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular22()
        lb.text = "Password"
        lb.textColor = .black
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let recoverPasswordButton = ReusableUIButton(style: .forgotPasswrod, title: nil)
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
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightBackgroundColor
        onboardingNavBar(titleText: "Welcome")
        
        configureTextFields()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Custom Buttons Methods
    
    @objc func eyeButtonTaped() {
        isPasswordHidden = !isPasswordHidden
        
        if isPasswordHidden {
            fieldEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        } else {
            fieldEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
    }

    // MARK: - Configure UI

    private func addSubviews() {
        
    }
    
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.rightView = fieldEyeButton
        passwordTextField.clearButtonMode = .never
        passwordTextField.rightViewMode = .always
        passwordTextField.rightView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}


// MARK: - UITextField Delegates

extension WellcomeViewController: UITextFieldDelegate {
    
}
