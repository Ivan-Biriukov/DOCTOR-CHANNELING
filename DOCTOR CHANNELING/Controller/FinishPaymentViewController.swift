
import UIKit

class FinishPaymentViewController: UIViewController {
    
    let descriptionText : String
    
    init(descriptionText: String) {
        self.descriptionText = descriptionText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Elements
    
    private let circleView : UIView = {
        let view = UIView()
        view.backgroundColor = .cellsBlueColor
        view.layer.borderWidth = 3
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let acceptImageView : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.accept)!)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let mainTitle : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold40()
        lb.textAlignment = .center
        lb.textColor = .cellsBlueColor
        lb.text = "Congratulations"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let descriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold20()
        lb.textAlignment = .center
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.text = "Your Payment Is Successfuly"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var backButton = ReusableUIButton(style: .mainBottomStyle, title: "Back")
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        addSubviews()
        setupConstraints()
        configureButton()
        self.descriptionLabel.text = descriptionText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Custom Buttons Methods
    
    @objc func backButtonTaped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - UI Settings
    
    private func addSubviews() {
        view.addSubview(circleView)
        circleView.addSubview(acceptImageView)
        view.addSubview(mainTitle)
        view.addSubview(descriptionLabel)
        view.addSubview(backButton)
    }
    
    private func configureButton() {
        backButton.addTarget(self, action: #selector(backButtonTaped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            acceptImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            acceptImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 47),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 23),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 86),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -86),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72)
            
        ])
    }


}
