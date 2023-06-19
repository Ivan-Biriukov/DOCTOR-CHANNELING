

 //Reworked into UIViewController+ Extension


//import UIKit
//
//class CustomNavigationController: UINavigationController {
//
//    enum BarStyle {
//        case onBoarding
//        case mainPage
//        case mainLight
//        case mainDark
//        case inChat
//    }
//
//    private let style : BarStyle
//    private let titleText : String
//    private let ringButton : UIButton
//
//    init(style: BarStyle, titleText: String, ringButton: UIButton?) {
//        self.style = style
//        self.titleText = titleText
//        super.init()
//        configureNavBar()
//    }
//
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//
//    private func configureNavBar() {
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.backgroundColor = .clear
//
//        switch style {
//        case .onBoarding:
//            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textLightBlue, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
//            self.navigationBar.topItem?.backBarButtonItem?.isHidden = true
//            self.title = titleText
//
//        case .mainPage:
//            let avatarIMG = UIImageView(image: UIImage(named: K.Avatars.userAvatarIcon))
//            avatarIMG.heightAnchor.constraint(equalToConstant: 70).isActive = true
//            avatarIMG.widthAnchor.constraint(equalToConstant: 70).isActive = true
//
//            let title = UILabel()
//            title.text = titleText
//            title.font = .averiaRegular22()
//            title.textColor = .black
//            title.textAlignment = .left
//
//            guard let btn = ringButton  else {
//                fatalError("Right view ring button doesnt exist")
//            }
//
//            let titleView = UIStackView(arrangedSubviews: [avatarIMG, title, btn])
//            titleView.axis = .horizontal
//            titleView.distribution = .fill
//            titleView.alignment = .center
//            titleView.tintColor = .black
//            self.navigationItem.titleView = titleView
//            self.navigationBar.topItem?.backBarButtonItem?.isHidden = true
//
//        case .mainLight:
//            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textLightBlue, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
//            self.navigationBar.topItem?.backBarButtonItem?.isHidden = false
//            self.title = titleText
//
//            let backButton = UIBarButtonItem()
//            backButton.image = UIImage(named: K.ButtonsImgs.NavBarButtons.back)
//            self.navigationBar.topItem?.backBarButtonItem = backButton
//
//        case .mainDark:
//            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
//            self.navigationBar.topItem?.backBarButtonItem?.isHidden = false
//            self.title = titleText
//
//            let backButton = UIBarButtonItem()
//            backButton.image = UIImage(named: K.ButtonsImgs.NavBarButtons.back)
//            self.navigationBar.topItem?.backBarButtonItem = backButton
//
//        case .inChat:
//            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textLightBlue, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
//            self.navigationBar.topItem?.backBarButtonItem?.isHidden = false
//            self.title = titleText
//
//            let backButton = UIBarButtonItem()
//            backButton.image = UIImage(named: K.ButtonsImgs.NavBarButtons.back)
//            self.navigationBar.topItem?.backBarButtonItem = backButton
//
//            let callButton = UIButton()
//            callButton.setImage(UIImage(named: K.ButtonsImgs.NavBarButtons.call), for: .normal)
//            callButton.addTarget(self, action: #selector(callButtonTaped), for: .touchUpInside)
//
//            let videoButton = UIButton()
//            videoButton.setImage(UIImage(named: K.ButtonsImgs.NavBarButtons.video), for: .normal)
//            videoButton.addTarget(self, action: #selector(videoButtonTaped), for: .touchUpInside)
//
//            let rightStack = UIStackView(arrangedSubviews: [callButton, videoButton])
//            rightStack.axis = .horizontal
//            rightStack.distribution = .fill
//            rightStack.alignment = .center
//            rightStack.spacing = 15
//
//            let rightBarButton = UIBarButtonItem(customView: rightStack)
//            self.navigationItem.rightBarButtonItem = rightBarButton
//        }
//        self.navigationBar.standardAppearance = navBarAppearance
//        self.navigationBar.scrollEdgeAppearance = navBarAppearance
//    }
//
//    @objc func callButtonTaped() {
//
//    }
//
//    @objc func videoButtonTaped() {
//
//    }
//
//}
