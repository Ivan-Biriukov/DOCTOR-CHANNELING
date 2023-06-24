import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Data
    
    private let collectionViewManager = InfoCollectionModelManager()
    private let doctorsCardsManager = DoctorsCardsManager()
    
    private var doctorsTenCategoryes : [String] = ["dentist", "surgeon", "urologist", "neurologist", "psychiatrist", "otolaryngologist", "obstetrician", "dermatologist", "cardiologist", "endocrinologist"
    ]
    private let moreDoctorsCategory : [String] = [
        "oncologist", "rheumatologist", "nephrologist", "pediatrician", "podiatrist", "ophthalmologist", "radiologist", "gynecologist", "geneticist", "physiologist", "allergist", "neurosurgeon", "hematologist", "microbiologist", "epidemiologist", "anaesthesiologist", "gastroenterologist", "immunologist", "infectious disease specialist", "intensivist", "neonatologist", "orthopedic surgeon", "parasitologist", "plastic surgeon", "pulmonologist"
    ]
    
    private var categorySeeAllIndicator : Int = 0
    
    // MARK: - UI Elements
    
    private let mainScrollContainer : UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let inScrollContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private let allDoctorsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular24()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.text = "All Doctors"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var doctorsSeeAllButton = ReusableUIButton(style: .seeAll, title: "See All")
    
    private let doctorsTableView : UITableView = {
        let tb = UITableView()
        tb.backgroundColor = .clear
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
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
       if categorySeeAllIndicator == 0 {
            for categorye in moreDoctorsCategory {
                doctorsTenCategoryes.append(categorye)
            }
           DispatchQueue.main.async {
               self.categoryesCollection.reloadData()
           }
      }
        categorySeeAllIndicator = 1
    }
    
    @objc func doctorsSeeAllButtonTaped() {
        
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(mainScrollContainer)
        mainScrollContainer.addSubview(inScrollContainer)
        inScrollContainer.addSubview(userAvatar)
        inScrollContainer.addSubview(userNameLabel)
        inScrollContainer.addSubview(bellButton)
        inScrollContainer.addSubview(searchBar)
        inScrollContainer.addSubview(infoCollection)
        inScrollContainer.addSubview(infoViewControll)
        inScrollContainer.addSubview(categoriesLabel)
        inScrollContainer.addSubview(categorySeeAllButton)
        inScrollContainer.addSubview(categoryesCollection)
        inScrollContainer.addSubview(allDoctorsLabel)
        inScrollContainer.addSubview(doctorsSeeAllButton)
        inScrollContainer.addSubview(doctorsTableView)
    }
    
    private func settingUpDelegates() {
        searchBar.delegate = self
        searchBar.searchDelegate = self
        searchBar.micDelegate = self
        infoCollection.delegate = self
        infoCollection.dataSource = self
        categoryesCollection.delegate = self
        categoryesCollection.dataSource = self
        doctorsTableView.delegate = self
        doctorsTableView.dataSource = self
    }
    
    private func registerCells() {
        infoCollection.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.mainPageInfoCell)
        categoryesCollection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.categoryesCell)
        doctorsTableView.register(DoctorCardTableViewCell.self, forCellReuseIdentifier: K.CellsIds.doctorsTableViewCell)
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
        doctorsSeeAllButton.addTarget(self, action: #selector(doctorsSeeAllButtonTaped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            mainScrollContainer.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            inScrollContainer.topAnchor.constraint(equalTo: mainScrollContainer.topAnchor),
            inScrollContainer.leadingAnchor.constraint(equalTo: mainScrollContainer.leadingAnchor),
            inScrollContainer.trailingAnchor.constraint(equalTo: mainScrollContainer.trailingAnchor),
            inScrollContainer.bottomAnchor.constraint(equalTo: mainScrollContainer.bottomAnchor),
            inScrollContainer.widthAnchor.constraint(equalTo: mainScrollContainer.widthAnchor),

            
            userAvatar.topAnchor.constraint(equalTo: inScrollContainer.topAnchor, constant: 75.81),
            userAvatar.leadingAnchor.constraint(equalTo: inScrollContainer.leadingAnchor, constant: 26.72),
            userNameLabel.topAnchor.constraint(equalTo: inScrollContainer.topAnchor, constant: 100.48),
            userNameLabel.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 19.64),
            bellButton.topAnchor.constraint(equalTo: inScrollContainer.topAnchor, constant: 94.81),
            bellButton.trailingAnchor.constraint(equalTo: inScrollContainer.trailingAnchor, constant: -26.72),

            searchBar.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 31.81),
            searchBar.leadingAnchor.constraint(equalTo: inScrollContainer.leadingAnchor, constant: 26.72),
            searchBar.trailingAnchor.constraint(equalTo: inScrollContainer.trailingAnchor, constant: -26.72),
        
            infoCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 31.81),
            infoCollection.leadingAnchor.constraint(equalTo: inScrollContainer.leadingAnchor,constant: 26.72),
            infoCollection.trailingAnchor.constraint(equalTo: inScrollContainer.trailingAnchor, constant: -26.72),
            
            infoViewControll.topAnchor.constraint(equalTo: infoCollection.bottomAnchor, constant: 15.5),
            infoViewControll.centerXAnchor.constraint(equalTo: inScrollContainer.centerXAnchor),
            
            categoriesLabel.topAnchor.constraint(equalTo: infoViewControll.bottomAnchor, constant: 15.31),
            categoriesLabel.leadingAnchor.constraint(equalTo: inScrollContainer.leadingAnchor, constant: 26.72),
            categorySeeAllButton.topAnchor.constraint(equalTo: infoViewControll.bottomAnchor, constant: 15.31),
            categorySeeAllButton.trailingAnchor.constraint(equalTo: inScrollContainer.trailingAnchor, constant: -26.72),
        
            categoryesCollection.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 30),
            categoryesCollection.leadingAnchor.constraint(equalTo: inScrollContainer.leadingAnchor, constant: 26.72),
            categoryesCollection.trailingAnchor.constraint(equalTo: inScrollContainer.trailingAnchor, constant: -26.72),
            
            allDoctorsLabel.topAnchor.constraint(equalTo: categoryesCollection.bottomAnchor, constant: 30),
            allDoctorsLabel.leadingAnchor.constraint(equalTo: inScrollContainer.leadingAnchor, constant: 26.72),
            doctorsSeeAllButton.topAnchor.constraint(equalTo: categoryesCollection.bottomAnchor, constant: 30),
            doctorsSeeAllButton.trailingAnchor.constraint(equalTo: inScrollContainer.trailingAnchor, constant: -26.72),
            
            doctorsTableView.topAnchor.constraint(equalTo: allDoctorsLabel.bottomAnchor, constant: 30),
            doctorsTableView.leadingAnchor.constraint(equalTo: inScrollContainer.leadingAnchor, constant: 26.72),
            doctorsTableView.trailingAnchor.constraint(equalTo: inScrollContainer.trailingAnchor, constant: -26.72),
            doctorsTableView.bottomAnchor.constraint(equalTo: inScrollContainer.bottomAnchor, constant: -10),
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


// MARK: - TableView Delegates & DataSource

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorsCardsManager.doctorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellsIds.doctorsTableViewCell, for: indexPath) as! DoctorCardTableViewCell
        
        let currentLastItem = doctorsCardsManager.doctorsArray[indexPath.row]
        cell.data = currentLastItem
        
        return cell
    }
    
    
}
