import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let bellButton = UIBarButtonItem(title: nil, style: .done, target: HomeViewController.self, action: #selector(bellButtonTaped))

    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    // MARK: - Custom Buttons Methods
    
    @objc func bellButtonTaped() {}
    
    // MARK: - Configure UI
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .red
        navBarAppearance.shadowColor = .clear
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        
        let titleLbl = UILabel()
                titleLbl.text = title
                titleLbl.textColor = UIColor.white
                titleLbl.font = .averiaBold22()
        
        let avatarButton = UIButton()
        avatarButton.setImage(UIImage(named: K.Avatars.userAvatarIcon), for: .normal)
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatarButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        let barAvatarButton = UIBarButtonItem(customView: avatarButton)
        

        self.navigationItem.leftBarButtonItem = barAvatarButton
        
        
        let titleView = UIStackView(arrangedSubviews: [titleLbl])
        titleView.axis = .horizontal
        titleView.distribution = .fill
        titleView.spacing = 10.0
        
        navigationItem.titleView = titleView

    }

}

