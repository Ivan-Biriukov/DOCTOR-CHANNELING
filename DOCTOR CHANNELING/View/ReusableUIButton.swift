
import UIKit

class ReusableUIButton: UIButton {

    enum ButtonStyle {
        case google
        case facebook
        case mainBottomStyle
        case singInOrSingUp
        case book
        case send
        case mic
    }

    private let style : ButtonStyle
    private let title : String?
    
    init(style: ButtonStyle, title: String?) {
        self.style = style
        self.title = title
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
        case .google:
            setImage(UIImage(named: K.ButtonsImgs.google)!, for: .normal)
            setTitle(nil, for: .normal)
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            widthAnchor.constraint(equalToConstant: 60).isActive = true
            layer.cornerRadius = 50
            
        case .facebook:
            setImage(UIImage(named: K.ButtonsImgs.facebook)!, for: .normal)
            setTitle(nil, for: .normal)
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            widthAnchor.constraint(equalToConstant: 60).isActive = true
            layer.cornerRadius = 50
            
        case .mainBottomStyle:
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            backgroundColor = .textLightBlue
            titleLabel?.textAlignment = .center
            titleLabel?.font = .averiaBold22()
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            layer.cornerRadius = 10
            
        case .singInOrSingUp:
            backgroundColor = .clear
            setTitle(title, for: .normal)
            titleLabel?.font = .montserratBold16()
            setTitleColor(.textLightBlue, for: .normal)
            
        case .book:
            setTitle("Book", for: .normal)
            backgroundColor = .textLightBlue
            setTitleColor(.white, for: .normal)
            titleLabel?.textAlignment = .center
            titleLabel?.font = .averiaRegular16()
            heightAnchor.constraint(equalToConstant: 28.38).isActive = true
            layer.cornerRadius = 20
            
        case .mic:
            setImage(UIImage(named: K.ButtonsImgs.mic), for: .normal)
            backgroundColor = .clear
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            widthAnchor.constraint(equalToConstant: 60).isActive = true
            layer.cornerRadius = 50
            
        case .send:
            setImage(UIImage(named: K.ButtonsImgs.send), for: .normal)
            backgroundColor = .clear
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            widthAnchor.constraint(equalToConstant: 60).isActive = true
            layer.cornerRadius = 50
        }
    }
    
    @objc func btnClicked (_ sender:UIButton) {
        self.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.alpha = 1.0
        }
    }

    
}
