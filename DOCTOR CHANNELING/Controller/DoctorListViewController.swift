import UIKit

class DoctorListViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private var doctorCardManager = DoctorsCardsManager()
    private let cellId = "CellId"
    
    private let searchBar = ReusableTextField(style: .searchField)
    private let doctorsListTableView : UITableView = {
        let tb = UITableView()
        tb.separatorStyle = .none
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        hideKeyboardWhenTappedAround()
        mainInterfaceNavBar(titleText: "All Doctors", isThemeLight: true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        addSubviews()
        setupConstraints()
        configureSearchField()
        configureTableView()
        doctorCardManager.loadAllDoctors()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }

    
    // MARK: - Custom Buttons Methods
    
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(doctorsListTableView)
    }
    
    private func configureSearchField() {
        searchBar.delegate = self
        searchBar.micDelegate = self
        searchBar.searchDelegate = self
    }
    
    private func configureTableView() {
        doctorsListTableView.delegate = self
        doctorsListTableView.dataSource = self
        doctorsListTableView.register(DoctorCardTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 144),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
            doctorsListTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 36),
            doctorsListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            doctorsListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
            doctorsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40)
        ])
    }
}

// MARK: - TextField Delegate Methods

extension DoctorListViewController : UITextFieldDelegate, FieldSearchButtonDelegate, FieldMicButtonDelegate {
    
    func searchButtonTaped() {
        
    }
    
    func micButtonTaped() {
        
    }
    
    
}


// MARK: - TableView Delegate & DataSource Methods

extension DoctorListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return doctorCardManager.doctorsArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DoctorCardTableViewCell
        
        let currentLastItem = doctorCardManager.doctorsArray[indexPath.section]
        
        cell.data = currentLastItem
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return " "
        }
    }


}
