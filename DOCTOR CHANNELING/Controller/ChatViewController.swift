import UIKit

class ChatViewController: UIViewController {
    
    
    // MARK: - UI Elements
    
    private lazy var callButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.NavBarButtons.call), for: .normal)
        btn.tintColor = .black
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(callButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var videoButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.NavBarButtons.video), for: .normal)
        btn.tintColor = .black
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(videoButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let navBarButtosStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let messageInputField = ReusableTextField(style: .chatTextInput)
    private lazy var sendButton = ReusableUIButton(style: .send, title: nil)
    private lazy var micButton = ReusableUIButton(style: .mic, title: nil)
    
    private let buttonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 13
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bottomLineStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        hideKeyboardWhenTappedAround()
        mainInterfaceNavBar(titleText: "MR. Pidor", isThemeLight: true)
        configureNavBarItems()
        addSubviews()
        configureTableView()
        configureTextField()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Buttons Methods
    
    @objc func callButtonTaped() {
        
    }
    
    @objc func videoButtonTaped() {
        
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(bottomLineStack)
        bottomLineStack.addArrangedSubview(messageInputField)
        bottomLineStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(micButton)
        buttonsStack.addArrangedSubview(sendButton)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
    }
    
    private func configureTextField() {
        messageInputField.delegate = self
        messageInputField.chatsDelegates = self
    }
    
    private func configureNavBarItems() {
        navBarButtosStack.addArrangedSubview(callButton)
        navBarButtosStack.addArrangedSubview(videoButton)
        let rightBarButton = UIBarButtonItem(customView: navBarButtosStack)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomLineStack.topAnchor, constant: -20),
            
            bottomLineStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            bottomLineStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            bottomLineStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }

}


// MARK: - TableView Delegate & DataSource

extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        cell.selectionStyle = .none
        
        cell.MyMessageBubleView.isHidden = true
        cell.enemeMessageText.text = "sdafsdfsdfsdfdasfsdfsasdfajsgjasfjgafsgjafsgjasfjgfasgjfagsjgfasgjfasgjafsgjafsgjafsgjafgsjjgfasjgfasgjafsgjasjgsafgjfasjgasfgjafsgjajfgsjg"
        
        return cell
    }
}

// MARK: - Custom TextField Delegate

extension ChatViewController : UITextFieldDelegate, ChatFieldButtonsDelegate {
    
    func smilesButtonTaped() {
        
    }
    
    func cameraButtonTaped() {
        
    }
    
}
