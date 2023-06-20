import UIKit

extension UIViewController {
    
    // MARK: - NavigationController Section
    
    func onboardingNavBar(titleText text: String) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textLightBlue, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.isHidden = true
        self.title = text
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func mainPageNavBar(avatarImage img : UIImage ,titleText: String, bellButton btn: UIBarButtonItem) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear

        let accountButton = UIBarButtonItem(image: UIImage(named: K.Avatars.userAvatarIcon), style: .done, target: self, action: nil)
        self.navigationController?.navigationItem.backBarButtonItem = accountButton
        
        
        let avatarIMG = UIImageView(image: img)
        avatarIMG.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatarIMG.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        let title = UILabel()
        title.text = titleText
        title.font = .averiaRegular22()
        title.textColor = .black
        title.textAlignment = .left
        
       let btn = btn
        
        let titleView = UIStackView(arrangedSubviews: [avatarIMG, title])
        titleView.axis = .horizontal
        titleView.distribution = .fill
        titleView.alignment = .center
        titleView.tintColor = .black
        self.navigationController?.navigationItem.titleView = titleView
      //  self.navigationController?.navigationBar.topItem?.backBarButtonItem?.isHidden = true
        
        self.navigationController?.navigationItem.rightBarButtonItem = btn
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    
    func mainInterfaceNavBar(titleText text: String, isThemeLight: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear

        if isThemeLight{
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textLightBlue, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
        } else {
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
        }
        
        navBarAppearance.backgroundColor = .clear
        
        let navBarBackButton = UIBarButtonItem()
        navBarBackButton.image = UIImage(named: K.ButtonsImgs.NavBarButtons.back)
        navBarBackButton.title = nil
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.isHidden = false
        self.title = text
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = navBarBackButton
    }
    
    func chatVCNavBar(titleText text: String, callButton: UIButton, videoButton: UIButton) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear

        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textLightBlue, NSAttributedString.Key.font: UIFont.averiaBold26() ?? UIFont.systemFont(ofSize: 26)]
        
        self.title = text
        
        let navBarBackButton = UIBarButtonItem()
        navBarBackButton.image = UIImage(named: K.ButtonsImgs.NavBarButtons.back)
        navBarBackButton.title = nil
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = navBarBackButton
        
        let rightStack = UIStackView(arrangedSubviews: [callButton, videoButton])
        rightStack.axis = .horizontal
        rightStack.distribution = .fill
        rightStack.alignment = .center
        rightStack.spacing = 15
        
        let rightBarButton = UIBarButtonItem(customView: rightStack)
        self.navigationController?.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func presentNewVC(vcToPresent vc: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let nextVC = vc
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    // MARK: - Other stuff
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
