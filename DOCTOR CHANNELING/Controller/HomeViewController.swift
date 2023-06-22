import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Data
    
    private let collectionViewManager = InfoCollectionModelManager()
    
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
    
    private let infoCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 54, height: 170)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 190).isActive = true
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let infoCollectionSegmentControll : UISegmentedControl = {
        let control = UISegmentedControl()
        control.selectedSegmentTintColor = .cellsBlueColor
        control.backgroundColor = .clear
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        addSubviews()
        setupConstraints()
        hideKeyboardWhenTappedAround()
        settingUpDelegates()
        registerCells()
        configureSegmentedControll()
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
        view.addSubview(infoCollection)
        view.addSubview(infoCollectionSegmentControll)
    }
    
    private func settingUpDelegates() {
        searchBar.delegate = self
        searchBar.searchDelegate = self
        searchBar.micDelegate = self
        infoCollection.delegate = self
        infoCollection.dataSource = self
    }
    
    private func registerCells() {
        infoCollection.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.mainPageInfoCell)
    }
    
    private func configureSegmentedControll() {
        infoCollectionSegmentControll.setImage(UIImage(systemName: "circle.fill"), forSegmentAt: 1)
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
        
            infoCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 31.81),
            infoCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 26.72),
            infoCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
            
            infoCollectionSegmentControll.topAnchor.constraint(equalTo: infoCollection.bottomAnchor, constant: 19.5),
            infoCollectionSegmentControll.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }

}

// MARK: - TextField Delegates

extension HomeViewController: UITextFieldDelegate, FieldSearchButtonDelegate, FieldMicButtonDelegate {
    
    func searchButtonTaped() {
        
    }
    
    func micButtonTaped() {
        
    }
    
}

// MARK: - CollectionView DataSource & Delegates

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewManager.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = infoCollection.dequeueReusableCell(withReuseIdentifier: K.CellsIds.mainPageInfoCell, for: indexPath) as! InfoCollectionViewCell
        
        let currentLastItem = collectionViewManager.dataArray[indexPath.row]
        cell.contentData = currentLastItem
        return cell
    }
    
    
}
