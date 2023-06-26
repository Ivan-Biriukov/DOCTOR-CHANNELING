
import UIKit

class DoctorDetailViewController: UIViewController {
    
    var doctorData : DoctorCardModel?
    
    // MARK: - UI Elements
    
    private let mainScrollContainer : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let scrollContentView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let doctorImageContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayBackgroundColor
        view.layer.borderWidth = 4
        view.layer.cornerRadius = 10
        view.layer.borderColor = CGColor(red: 144/256, green: 144/256, blue: 144/256, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let doctorAvatarImg : UIImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleToFill
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private let topRightMainStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 13
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let doctorNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold24()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Dr.Upul"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let contactsButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var chatButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.BookVC.chatButton), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(chatButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var callButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.BookVC.callButton), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(callButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var videoCallButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.BookVC.videoCallButton), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(videoCallButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let professionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular20()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "denteeth"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let shortDescriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular13()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.text = "Torem ipsum dolor sit amet, consectetur adipiscing elit."
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let paymentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let paymentTitleLabe : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular20()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Payment"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let paymentCostLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular20()
        lb.textAlignment = .right
        lb.textColor = .black
        lb.text = "$ 120.00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular24()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Detailes"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsDescriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular15()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl."
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let workingsHoursTitle : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular24()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Working Hours"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var workingHoursSeeAllButton = ReusableUIButton(style: .seeAll, title: "See All")
    
    private let workingHoursCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 56)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let dateTitle : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular24()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Date"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var dateSeeAllButton = ReusableUIButton(style: .seeAll, title: "See All")
    
    private let dateCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 76)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var bookButton = ReusableUIButton(style: .mainBottomStyle, title: "Book an Appointment")
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        mainInterfaceNavBar(titleText: "Appointment", isThemeLight: true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        configureCollections()
        setupButtonsMethods()
        self.navigationController?.hidesBarsOnSwipe = true
        
        
        
        
        doctorAvatarImg.image = UIImage(named: K.Doctors.secondDoctorImage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    // MARK: - Custom Buttons Methods
    
    @objc func chatButtonTaped() {
        
    }
    
    @objc func callButtonTaped() {
        
    }
    
    @objc func videoCallButtonTaped() {
        
    }
    
    @objc func workHoursButtonTaped() {
        
    }
    
    @objc func dateButtonTaped() {
        
    }
    
    @objc func bookButtonTaped() {
        
    }
    
    // MARK: - Configure UI

    private func addSubviews() {
        view.addSubview(mainScrollContainer)
        mainScrollContainer.addSubview(scrollContentView)
        scrollContentView.addSubview(doctorImageContainer)
        doctorImageContainer.addSubview(doctorAvatarImg)
        scrollContentView.addSubview(topRightMainStack)
        topRightMainStack.addArrangedSubview(doctorNameLabel)
        topRightMainStack.addArrangedSubview(contactsButtonsStack)
        contactsButtonsStack.addArrangedSubview(chatButton)
        contactsButtonsStack.addArrangedSubview(callButton)
        contactsButtonsStack.addArrangedSubview(videoCallButton)
        topRightMainStack.addArrangedSubview(professionLabel)
        topRightMainStack.addArrangedSubview(shortDescriptionLabel)
        topRightMainStack.addArrangedSubview(paymentStack)
        paymentStack.addArrangedSubview(paymentTitleLabe)
        paymentStack.addArrangedSubview(paymentCostLabel)
        scrollContentView.addSubview(detailsStack)
        detailsStack.addArrangedSubview(detailsTitleLabel)
        detailsStack.addArrangedSubview(detailsDescriptionLabel)
        scrollContentView.addSubview(workingsHoursTitle)
        scrollContentView.addSubview(workingHoursSeeAllButton)
        scrollContentView.addSubview(workingHoursCollection)
        scrollContentView.addSubview(dateTitle)
        scrollContentView.addSubview(dateSeeAllButton)
        scrollContentView.addSubview(dateCollection)
        view.addSubview(bookButton)
    }

    private func setupButtonsMethods() {
        workingHoursSeeAllButton.addTarget(self, action: #selector(workHoursButtonTaped), for: .touchUpInside)
        dateSeeAllButton.addTarget(self, action: #selector(dateButtonTaped), for: .touchUpInside)
        bookButton.addTarget(self, action: #selector(bookButtonTaped), for: .touchUpInside)
    }
    
    private func configureCollections() {
        workingHoursCollection.delegate = self
        workingHoursCollection.dataSource = self
        workingHoursCollection.register(TimeSlotCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.timeSlotCollectionCell)
        dateCollection.delegate = self
        dateCollection.dataSource = self
        dateCollection.register(TimeSlotCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.timeSlotCollectionCell)
        dateCollection.isScrollEnabled = true
        mainScrollContainer.delegate = self
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainScrollContainer.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollContainer.bottomAnchor.constraint(equalTo: bookButton.topAnchor, constant: -10),
            scrollContentView.topAnchor.constraint(equalTo: mainScrollContainer.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: mainScrollContainer.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: mainScrollContainer.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: mainScrollContainer.bottomAnchor, constant: -20),
            scrollContentView.centerXAnchor.constraint(equalTo: mainScrollContainer.centerXAnchor),
            scrollContentView.centerYAnchor.constraint(equalTo: mainScrollContainer.centerYAnchor),
            
            doctorImageContainer.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 54),
            doctorImageContainer.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 16.72),
            doctorImageContainer.widthAnchor.constraint(equalToConstant: 148),
            doctorImageContainer.heightAnchor.constraint(equalToConstant: 190),
            doctorAvatarImg.topAnchor.constraint(equalTo: doctorImageContainer.topAnchor, constant: 6),
            doctorAvatarImg.leadingAnchor.constraint(equalTo: doctorImageContainer.leadingAnchor, constant: 6),
            doctorAvatarImg.trailingAnchor.constraint(equalTo: doctorImageContainer.trailingAnchor, constant: -6),
            doctorAvatarImg.bottomAnchor.constraint(equalTo: doctorImageContainer.bottomAnchor, constant: -6),
            
            topRightMainStack.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 54),
            topRightMainStack.leadingAnchor.constraint(equalTo: doctorImageContainer.trailingAnchor, constant: 23.5),
            topRightMainStack.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -19),
            
            detailsStack.topAnchor.constraint(equalTo: doctorImageContainer.bottomAnchor, constant: 40),
            detailsStack.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 16.72),
            detailsStack.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -19),
            
            workingsHoursTitle.topAnchor.constraint(equalTo: detailsStack.bottomAnchor, constant: 34),
            workingsHoursTitle.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 16.72),
            workingHoursSeeAllButton.topAnchor.constraint(equalTo: detailsStack.bottomAnchor, constant: 34),
            workingHoursSeeAllButton.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -19),
            workingHoursCollection.topAnchor.constraint(equalTo: workingsHoursTitle.bottomAnchor, constant: 24),
            workingHoursCollection.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 16.72),
            workingHoursCollection.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -19),
            workingHoursCollection.heightAnchor.constraint(equalToConstant: 60),
            
            dateTitle.topAnchor.constraint(equalTo: workingHoursCollection.bottomAnchor, constant: 29),
            dateTitle.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 16.72),
            dateSeeAllButton.topAnchor.constraint(equalTo: workingHoursCollection.bottomAnchor, constant: 29),
            dateSeeAllButton.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -19),
            dateCollection.topAnchor.constraint(equalTo: workingHoursCollection.bottomAnchor, constant: 74),
            dateCollection.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 16.72),
            dateCollection.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -19),
            dateCollection.heightAnchor.constraint(equalToConstant: 76),
            
            bookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.72),
            bookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            bookButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
    }
}


// MARK: - Collection Delegate & Datasource

extension DoctorDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == workingHoursCollection {
            return 5
        } else {
            return 29
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellsIds.timeSlotCollectionCell, for: indexPath) as! TimeSlotCollectionViewCell

        if collectionView == workingHoursCollection {
            cell.timeLabel.text = "10.00 AM"
        } else {
            let date = 1
            cell.timeLabel.text = "\(date + indexPath.row)"
        }
        return cell

    }
}

// MARK: - Scroll Delegate

extension DoctorDetailViewController: UIScrollViewDelegate {

}
