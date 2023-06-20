protocol FieldeyeButtonDelegate {
    func eyeButtonTaped()
}

import UIKit

class ReusableTextField: UITextField {
    
    enum FieldStyle : String {
        case email = "Enter Your Email"
        case password = "Enter Your Password"
        case name = "Enter Your Full Name"
        case phoneNumber = "Enter Your Phone Number"
        case chatTextInput = "Write here"
    }
    
    
    private let style : FieldStyle
    var buttonDelegate: FieldeyeButtonDelegate?
    private var isPasswordHidden : Bool = true
    
    init(style: FieldStyle) {
        self.style = style
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 211/256, green: 211/256, blue: 211/256, alpha: 1)
        //CGColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 1)
        backgroundColor = .lightGrayBackgroundColor
        
        attributedPlaceholder = NSAttributedString (
            string: style.rawValue,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.textUnavalibleGray,
                NSAttributedString.Key.font: UIFont.averiaRegular18() ?? UIFont.systemFont(ofSize: 18)
            ]
        )
        font = .averiaRegular18()
        textColor = .black
        textAlignment = .left
        tintColor = .textLightBlue
        translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        if style == .email {
            keyboardType = .emailAddress
            clearButtonMode = .whileEditing
        } else if style == .password {
            rightStackView.addArrangedSubview(fieldEyeButton)
            rightStackView.addArrangedSubview(spaceContainer)
            isSecureTextEntry = true
            rightView = rightStackView
            clearButtonMode = .never
            rightViewMode = .always
        } else if style == .phoneNumber {
            clearButtonMode = .whileEditing
            keyboardType = .phonePad
        } else if style == .name {
            clearButtonMode = .whileEditing
            keyboardType = .namePhonePad
        }
    }
    
    private let rightStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var fieldEyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.addTarget(self, action: #selector(eyeButtonTaped), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let spaceContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func eyeButtonTaped() {
        buttonDelegate?.eyeButtonTaped()
        isPasswordHidden = !isPasswordHidden
        if isPasswordHidden {
            fieldEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            isSecureTextEntry = true
        } else {
            fieldEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            isSecureTextEntry = false
        }
    }
}
