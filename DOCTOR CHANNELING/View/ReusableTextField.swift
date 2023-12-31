protocol FieldeyeButtonDelegate {
    func eyeButtonTaped()
}

protocol FieldSearchButtonDelegate {
   func searchButtonTaped()
}

protocol FieldMicButtonDelegate {
    func micButtonTaped()
}

protocol ChatFieldButtonsDelegate {
    func smilesButtonTaped()
    func cameraButtonTaped()
}
import UIKit

class ReusableTextField: UITextField {
    
    enum FieldStyle : String {
        case email = "Enter Your Email"
        case password = "Enter Your Password"
        case name = "Enter Your Full Name"
        case phoneNumber = "Enter Your Phone Number"
        case chatTextInput = "Write here"
        case searchField = "Search a Doctor"
        case paymentVCReusable = ""
        
    }
    
    
    private let style : FieldStyle
    var buttonDelegate : FieldeyeButtonDelegate?
    var searchDelegate : FieldSearchButtonDelegate?
    var micDelegate : FieldMicButtonDelegate?
    private var isPasswordHidden : Bool = true
    var chatsDelegates : ChatFieldButtonsDelegate?
    
    init(style: FieldStyle) {
        self.style = style
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 211/256, green: 211/256, blue: 211/256, alpha: 1)
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
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            keyboardType = .emailAddress
            clearButtonMode = .whileEditing
        } else if style == .password {
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            rightStackView.addArrangedSubview(fieldEyeButton)
            rightStackView.addArrangedSubview(spaceContainer)
            isSecureTextEntry = true
            rightView = rightStackView
            clearButtonMode = .never
            rightViewMode = .always
        } else if style == .phoneNumber {
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            clearButtonMode = .whileEditing
            keyboardType = .phonePad
        } else if style == .name {
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            clearButtonMode = .whileEditing
            keyboardType = .namePhonePad
        } else if style == .searchField {
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            tintColor = .textUnavalibleGray
            leftStackView.addArrangedSubview(leftSpaceContainer)
            leftStackView.addArrangedSubview(searchButton)
            leftStackView.addArrangedSubview(spaceBetweenSearchAndText)
            leftView = leftStackView
            rightStackView.addArrangedSubview(micButton)
            rightStackView.addArrangedSubview(spaceContainer)
            rightView = rightStackView
            clearButtonMode = .never
            rightViewMode = .always
        } else if style == .paymentVCReusable {
            layer.borderWidth = 0
            font = .averiaRegular16()
            heightAnchor.constraint(equalToConstant: 50).isActive = true
            keyboardType = .numberPad
            clearButtonMode = .whileEditing
            tintColor = .black
        } else if style == .chatTextInput {
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            font = .averiaRegular16()
            keyboardType = .default
            clearButtonMode = .never
            leftStackView.addArrangedSubview(leftSpaceContainer)
            leftStackView.addArrangedSubview(smilesButton)
            leftStackView.addArrangedSubview(spaceBetweenSearchAndText)
            leftView = leftStackView
            leftViewMode = .always
            rightStackView.addArrangedSubview(cameraButton)
            rightStackView.addArrangedSubview(spaceContainer)
            rightView = rightStackView
            rightViewMode = .always
        }
    }
    
    private let rightStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let leftStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let leftSpaceContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let spaceBetweenSearchAndText : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private lazy var searchButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.addTarget(self, action: #selector(searchButtonTaped), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var micButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "mic"), for: .normal)
        btn.addTarget(self, action: #selector(micButtonTaped), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var smilesButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "face.smiling"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(smilesButtonTaped), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var cameraButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(cameraButtonTaped), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
    
    @objc func searchButtonTaped() {
        searchDelegate?.searchButtonTaped()
    }
    
    @objc func micButtonTaped() {
        micDelegate?.micButtonTaped()
    }
    
    @objc func smilesButtonTaped() {
        chatsDelegates?.smilesButtonTaped()
    }
    
    @objc func cameraButtonTaped() {
        chatsDelegates?.cameraButtonTaped()
    }
}
