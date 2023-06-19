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
        
        if style == .email {
            keyboardType = .emailAddress
            clearButtonMode = .whileEditing
            
        }
    }
}
