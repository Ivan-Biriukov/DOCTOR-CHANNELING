import UIKit

class ChatListViewController: UIViewController {
    
    private let dataArray : [ChatWithDoctorModel] = [
        .init(isDoctorAvalible: true, doctorAvatar: UIImage(named: K.Avatars.firstDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Upul", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "12:50", unreadMessagesValue: 2)),
        
        .init(isDoctorAvalible: true, doctorAvatar: UIImage(named: K.Avatars.secondDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Silva", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "03:35", unreadMessagesValue: 0)),
        
        .init(isDoctorAvalible: true, doctorAvatar: UIImage(named: K.Avatars.thirdDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Pawani", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "15:15", unreadMessagesValue: 0)),
        
        .init(isDoctorAvalible: false, doctorAvatar: UIImage(named: K.Avatars.secondDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Rayan", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "09:15", unreadMessagesValue: 0)),
        
        .init(isDoctorAvalible: true, doctorAvatar: UIImage(named: K.Avatars.firstDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Morgen", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "16:50", unreadMessagesValue: 5)),
        
        .init(isDoctorAvalible: true, doctorAvatar: UIImage(named: K.Avatars.secondDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Andrew", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "16:32", unreadMessagesValue: 7)),
        
        .init(isDoctorAvalible: true, doctorAvatar: UIImage(named: K.Avatars.thirdDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Pawani", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "15:15", unreadMessagesValue: 0)),
        
        .init(isDoctorAvalible: false, doctorAvatar: UIImage(named: K.Avatars.secondDoctorAvatar)!, chatHistory: chatHistoryData(contactName: "Dr.Pawani", lastMessage: "Worem consectetur adipiscing elit.", lastMessageTime: "15:15", unreadMessagesValue: 0)),
    ]
    
    // MARK: - UI Elements
    
    private let searchBar = ReusableTextField(style: .searchField)
    
    private let activeNowLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular24()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.text = "Active Now"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let activeNowCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 27.46
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 80).isActive = true
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let messagesTitle : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular24()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.text = "Messages"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let messagesTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mainInterfaceNavBar(titleText: "Message", isThemeLight: true)

        addSubviews()
        setupCollection()
        setupTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(activeNowLabel)
        view.addSubview(activeNowCollection)
        view.addSubview(messagesTitle)
        view.addSubview(messagesTableView)
    }
    
    private func setupCollection() {
        activeNowCollection.delegate = self
        activeNowCollection.dataSource = self
        activeNowCollection.register(ActiveNowChatCollectionViewCell.self, forCellWithReuseIdentifier: "chatListCollectionCell")
    }
    
    private func setupTableView() {
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(ChatsContactsTableViewCell.self, forCellReuseIdentifier: "chatListCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 144),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
            activeNowLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 36),
            activeNowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            activeNowCollection.topAnchor.constraint(equalTo: activeNowLabel.bottomAnchor, constant: 24),
            activeNowCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            activeNowCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
            messagesTitle.topAnchor.constraint(equalTo: activeNowCollection.bottomAnchor, constant: 24),
            messagesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            messagesTableView.topAnchor.constraint(equalTo: messagesTitle.bottomAnchor, constant: 36),
            messagesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26.72),
            messagesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26.72),
            messagesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
        ])
    }

}

// MARK: - Collection Delegate

extension ChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = activeNowCollection.dequeueReusableCell(withReuseIdentifier: "chatListCollectionCell", for: indexPath) as! ActiveNowChatCollectionViewCell
        
        let currentLastItem = dataArray[indexPath.row]
        cell.doctorAvatar.image = currentLastItem.doctorAvatar
        let status = currentLastItem.isDoctorAvalible
        if let safeBoolStatus = status {
            cell.changeDoctorStatus(doctorStatus: safeBoolStatus)
        }
        return cell
    }
}

// MARK: - Extension TableView Delegate & DataSource

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return " "
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as! ChatsContactsTableViewCell
        
        let currentLastItem = dataArray[indexPath.section]
        cell.data = currentLastItem
        
        if currentLastItem.chatHistory?.unreadMessagesValue == 0 {
            cell.unreadedMessageIndicatorView.isHidden = true
            cell.unreadedMessageCountLabel.isHidden = true
            cell.lastMessageTextlabel.textColor = .black
        } else {
            cell.unreadedMessageIndicatorView.isHidden = false
            cell.unreadedMessageCountLabel.isHidden = false
            cell.unreadedMessageCountLabel.text = "\(currentLastItem.chatHistory?.unreadMessagesValue ?? 0)"
            cell.lastMessageTextlabel.textColor = .cellsBlueColor
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.navigationController?.pushViewController(ChatViewController(), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
