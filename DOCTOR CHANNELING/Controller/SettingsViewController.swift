import UIKit
import FirebaseAuth
import FirebaseFirestore


class SettingsViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    private let dataArray : [SettingsDataModel] = [
        .init(image: UIImage(named: K.ButtonsImgs.ProfileButtons.history)!, title: "History", rightButtonNeeded: true),
        .init(image: UIImage(named:K.ButtonsImgs.ProfileButtons.personalData)!, title: "Personal Datailes", rightButtonNeeded: true),
        .init(image: UIImage(named:K.ButtonsImgs.ProfileButtons.location)!, title: "Location", rightButtonNeeded: true),
        .init(image: UIImage(named:K.ButtonsImgs.ProfileButtons.payment)!, title: "Payment Method", rightButtonNeeded: true),
        .init(image: UIImage(named:K.ButtonsImgs.ProfileButtons.setting)!, title: "Settings", rightButtonNeeded: true),
        .init(image: UIImage(named:K.ButtonsImgs.ProfileButtons.help)!, title: "Help", rightButtonNeeded: true),
        .init(image: UIImage(named:K.ButtonsImgs.ProfileButtons.logOut)!, title: "Logout", rightButtonNeeded: false)
    ]
    
    // MARK: - UI Elemetns
    
    private let userAvatar : UIImageView = {
        let avatar = UIImageView()
        avatar.widthAnchor.constraint(equalToConstant: 130).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 130).isActive = true
        avatar.layer.cornerRadius = 65
        avatar.contentMode = .scaleToFill
        avatar.image = UIImage(named: "user")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private let userNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold22()
        lb.textColor = .black
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let configsTableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
        
// MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInfoData()
        view.backgroundColor = .systemBackground
        mainInterfaceNavBar(titleText: "Profile", isThemeLight: true)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.isHidden = true
        
        addSubviews()
        setupTableView()
        setupConstraints()
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(userAvatar)
        view.addSubview(userNameLabel)
        view.addSubview(configsTableView)
    }
    
    private func setupTableView() {
        configsTableView.delegate = self
        configsTableView.dataSource = self
        configsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        configsTableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 97),
            userAvatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 29),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            configsTableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 37),
            configsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            configsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            configsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110)
        ])
    }
}

// MARK: - TableView Delegates & DataSource

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = configsTableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        
        let currentLastItem = dataArray[indexPath.row]
        cell.cellData = currentLastItem
        cell.tintColor = .black
        
        if currentLastItem.rightButtonNeeded {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.last == dataArray.count - 1 {
            let logoutAlert = UIAlertController(title: "Logout", message: "Are you shure to logout from current account?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) {action in
                do {
                    try Auth.auth().signOut()
                    let vcToPresent = UINavigationController(rootViewController: WellcomeViewController())
                    vcToPresent.modalPresentationStyle = .fullScreen
                    self.present(vcToPresent, animated: true)
                } catch let signOutError as NSError {
                    let logoutErrorAlert = UIAlertController(title: "Logout Problems", message: signOutError.localizedDescription, preferredStyle: .alert)
                    let errorAction = UIAlertAction(title: "Got it", style: .cancel)
                    logoutErrorAlert.addAction(errorAction)
                    self.present(logoutErrorAlert, animated: true)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            logoutAlert.addAction(confirmAction)
            logoutAlert.addAction(cancelAction)
            self.present(logoutAlert, animated: true)
        }
    }
}

// MARK: - Load Data from FireBase

extension SettingsViewController {
    
    private func loadUserInfoData() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        print(doc.documentID)
                            let usernName = data["userName"] as? String
                        self.userNameLabel.text = usernName?.capitalized

                    }
                }
            }
        }
    }
    
}

