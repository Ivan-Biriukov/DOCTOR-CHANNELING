import UIKit
import FSCalendar

class TimeAndDateViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let calendar = FSCalendar()
    
    private let timeSlotLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold24()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Available Time Slot"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var seeAllButton = ReusableUIButton(style: .seeAll, title: "See All")
    
    private let timeSlotCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 56)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var setAppointmentButton = ReusableUIButton(style: .mainBottomStyle, title: "Set Appointment")
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mainInterfaceNavBar(titleText: "Select date and time", isThemeLight: true)
        addSubviews()
        setupConstraints()
        configureCalendar()
        addButtonsMethods()
        configureCollection()
    }
    
    
    
    // MARK: - Custom Buttons Methods
    
    @objc func seeAllButtonTaped() {
        
    }
    
    @objc func setAppointmentButtonTaped() {
        
    }
    
    // MARK: - COnfigure UI
    
    private func addSubviews() {
        view.addSubview(calendar)
        view.addSubview(timeSlotLabel)
        view.addSubview(seeAllButton)
        view.addSubview(timeSlotCollection)
        view.addSubview(setAppointmentButton)
    }

    private func configureCalendar() {
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    private func configureCollection() {
        timeSlotCollection.dataSource = self
        timeSlotCollection.delegate = self
        timeSlotCollection.register(TimeSlotCollectionViewCell.self, forCellWithReuseIdentifier: K.CellsIds.timeSlotCollectionCell)
    }
    
    private func addButtonsMethods() {
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTaped), for: .touchUpInside)
        setAppointmentButton.addTarget(self, action: #selector(setAppointmentButtonTaped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 410),
            
            timeSlotLabel.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 33),
            timeSlotLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            seeAllButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 33),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            timeSlotCollection.topAnchor.constraint(equalTo: timeSlotLabel.bottomAnchor, constant: 20),
            timeSlotCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeSlotCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeSlotCollection.heightAnchor.constraint(equalToConstant: 58),
            
            setAppointmentButton.topAnchor.constraint(equalTo: timeSlotCollection.bottomAnchor, constant: 40),
            setAppointmentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setAppointmentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
}


// MARK: - FSCalendar Delegate & DataSource

extension TimeAndDateViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let selectedDate = formatter.string(from: date)
        print("дата: \(selectedDate)")
    }
}

// MARK: - CollectionView Delegate & DataSource

extension TimeAndDateViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellsIds.timeSlotCollectionCell, for: indexPath) as! TimeSlotCollectionViewCell
        
        cell.timeLabel.text = "11.00 PM"
        
        return cell
    }
    
    
}
