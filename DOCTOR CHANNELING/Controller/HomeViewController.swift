import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Data
    
    private let collectionViewManager = InfoCollectionModelManager()
    private var doctorsTenCategoryes : [String] = ["dentist", "surgeon", "urologist", "neurologist", "psychiatrist", "otolaryngologist", "obstetrician", "dermatologist", "cardiologist", "endocrinologist"
    ]
    private let moreDoctorsCategory : [String] = [
        "oncologist", "rheumatologist", "nephrologist", "pediatrician", "podiatrist", "ophthalmologist", "radiologist", "gynecologist", "geneticist", "physiologist", "allergist", "neurosurgeon", "hematologist", "microbiologist", "epidemiologist", "anaesthesiologist", "gastroenterologist", "immunologist", "infectious disease specialist", "intensivist", "neonatologist", "orthopedic surgeon", "parasitologist", "plastic surgeon", "pulmonologist"
    ]
    
    private var categorySeeAllIndicator : Int = 0
    
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
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var infoViewControll : UIPageControl = {
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = .cellsBlueColor
        control.pageIndicatorTintColor = .lightGrayBackgroundColor
        control.isUserInteractionEnabled = false
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let categoriesLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular24()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.text = "Categories"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var categorySeeAllButton = ReusableUIButton(style: .seeAll, title: "See All")
    
    private let categoryesCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 80)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 80).isActive = true
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
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
        configureInfoPageControll()
        configureButtonsActions()
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
    
    @objc func categorySeeAllTaped() {
        print("check")
        print(categorySeeAllIndicator)
//        if categorySeeAllIndicator == 0 {
//            for categorye in moreDoctorsCategory {
//                doctorsTenCategoryes.append(categorye)
//            }
//            print("123")
//        }
//        DispatchQueue.main.async {
//            self.infoCollection.reloadData()
//        }
//        categorySeeAllIndicator = 1
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(userAvatar)
        view.addSubview(userNameLabel)
        view.addSubview(bellButton)
        view.addSubview(searchBar)
        view.addSubview(infoCollection)
        view.addSubview(infoViewControll)
        view.addSubview(categoriesLabel)
        view.addSubview(categorySeeAllButton)
        view.addSubview(categoryesCollection)
    }
    
    private func settingUpDelegates() {
        searchBar.delegate = self
        searchBar.searchDelegate = self
        searchBar.micDelegate = self
        infoCollection.delegate = self
        infoCollection.dataSource = self
        categoryesCollection.delegate = self
        categoryesCollection.dataSource = self
    }
    
    private func registerCells() {
        infoCollection.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.mainPageInfoCell)
        categoryesCollection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.categoryesCell)
    }
    
    private func configureInfoPageControll() {
        infoViewControll.numberOfPages = self.collectionViewManager.dataArray.count
        infoViewControll.currentPage = 0
        infoViewControll.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    private func configureButtonsActions() {
        categorySeeAllButton.addTarget(self, action: #selector(categorySeeAllTaped), for: .touchUpInside)
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
            
            infoViewControll.topAnchor.constraint(equalTo: infoCollection.bottomAnchor, constant: 15.5),
            infoViewControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoriesLabel.topAnchor.constraint(equalTo: infoViewControll.bottomAnchor, constant: 15.31),
            categoriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            categorySeeAllButton.topAnchor.constraint(equalTo: infoViewControll.bottomAnchor, constant: 15.31),
            categorySeeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
        
            categoryesCollection.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 30),
            categoryesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            categoryesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
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
        
        if collectionView == infoCollection {
            return collectionViewManager.dataArray.count
        } else {
            return doctorsTenCategoryes.count
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == infoCollection {
            
            let cell = infoCollection.dequeueReusableCell(withReuseIdentifier: K.CellsIds.mainPageInfoCell, for: indexPath) as! InfoCollectionViewCell
            
            let currentLastItem = collectionViewManager.dataArray[indexPath.row]
            cell.contentData = currentLastItem
            return cell
            
        } else {
            
            let cell = categoryesCollection.dequeueReusableCell(withReuseIdentifier: K.CellsIds.categoryesCell, for: indexPath) as! CategoryCollectionViewCell
            
            let currentLastItem = doctorsTenCategoryes[indexPath.row]
            cell.categoryCellLabel.text = currentLastItem
            return cell
        }
        

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.infoCollection.contentOffset, size: self.infoCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.infoCollection.indexPathForItem(at: visiblePoint) {
            self.infoViewControll.currentPage = visibleIndexPath.row
        }
    }
    
}
