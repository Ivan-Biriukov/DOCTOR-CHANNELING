import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let userAvatar : UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: K.Avatars.userAvatarIcon)
        avatar.contentMode = .scaleToFill
        avatar.layer.cornerRadius = 70
        avatar.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private let userNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular22()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.text = "Chathura"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var bellButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.NavBarButtons.ring), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 22)
        btn.imageView?.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(bellButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let searchBar = ReusableTextField(style: .searchField)
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        addSubviews()
        setupConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    // MARK: - Custom Buttons Methods
    
    @objc func bellButtonTaped() {
        bellButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.bellButton.alpha = 1.0
        }
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(userAvatar)
        view.addSubview(userNameLabel)
        view.addSubview(bellButton)
        view.addSubview(searchBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            userAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 75.81),
            userAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            userNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.48),
            userNameLabel.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 19.64),
            bellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 94.81),
            bellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),

            searchBar.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 31.81),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
        
        
        
        ])
    }
 

}

