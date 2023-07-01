import UIKit

class ChatViewController: UIViewController {
    
    private let doctorName : String
    
   // MARK: - Init
    
    init(doctorName: String) {
        self.doctorName = doctorName
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Elements
    
    private lazy var callButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.NavBarButtons.call), for: .normal)
        btn.tintColor = .black
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(callButtonTaped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var videoButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.ButtonsImgs.NavBarButtons.video), for: .normal)
        btn.tintColor = .black
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(videoButtonTaped), for: .touchUpInside)
        return btn
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
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   chatVCNavBar(titleText: doctorName, callButton: callButton, videoButton: videoButton)
        addSubviews()
        configureTableView()
        configureTextField()
        setupConstraints()
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
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "chatCell")
    }
    
    private func configureTextField() {
        messageInputField.delegate = self
        messageInputField.chatsDelegates = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 145),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomLineStack.topAnchor, constant: -20),
            
            bottomLineStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! MessageTableViewCell
        cell.senderIsMe(messageText: "test test test test")
        
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
