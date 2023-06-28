import Veil
import UIKit

class PaymentViewController: UIViewController {
    
    private let paymentsVariationsArray : [String] = ["Card Payment","Cash Payment"]
    private var confirmButtonStatus : Bool = false
    private var userPaymentInfo : UserCardInfo?
    var descriptionChoises : [String] = ["Your Payment Is Successfuly", "The backup of your doctor's appointment was successful"]
    
    // MARK: - UI Elements
    
    private let costTitle : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold50()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.text = "$ 120.00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let methodsTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaBold20()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Doctor Chanaling Payment Method"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private var paymentMethodsControl = UISegmentedControl()
    
    // CardPay View Elements
    
    private let cardPaymentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cardNumberLabel : UILabel  = {
        let lb = UILabel()
        lb.font = .averiaRegular18()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Card Number"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let cardNumberTextField = ReusableTextField(style: .paymentVCReusable)
    
    private let expiryDateLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular18()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Expiry Date"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let expiryDateTextField = ReusableTextField(style: .paymentVCReusable)
    
    private let cvcLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular18()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "CVC"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let cvcTextField = ReusableTextField(style: .paymentVCReusable)
    
    private let cardholderNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular18()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.text = "Name"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let cardholderNameTextField = ReusableTextField(style: .paymentVCReusable)
    
    private lazy var payNowButton = ReusableUIButton(style: .mainBottomStyle, title: "Pay Now")
    
    // CashPay View Elements
    
    private let cashPaymentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cashPaymentMainLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular18()
        lb.textAlignment = .center
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.text = "Using the method of payment for the reception - cash, you confirm your responsibility when making an appointment. If you do not show up for an appointment, you may be denied further registration. Payment in cash, only a correspondence appointment with a specialist is possible."
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let aproovmentLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular28()
        lb.textAlignment = .left
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.text = "Confirm"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var confirmButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "square"), for: .normal)
        btn.tintColor = UIColor.red
        btn.addTarget(self, action: #selector(confirmButtonPressed(_:)), for: .touchUpInside)
        btn.setTitle(nil, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 35).isActive = true
        btn.imageView!.contentMode = .scaleToFill
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var reserveButton = ReusableUIButton(style: .mainBottomStyle, title: "Reserve")
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainInterfaceNavBar(titleText: "Payment", isThemeLight: false)
        view.backgroundColor = .cellsBlueColor
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        hideKeyboardWhenTappedAround()
        
        configureSegmentedControl()
        addSubviews()
        setupConstraints()
        addButtonsMethods()
        configureButtons()
        configureTextFields()
        cashPaymentView.isHidden = true
        


    }
    
    
    // MARK: - Custom Buttons Methods
    
    @objc func payNowButtonTaped() {
        
//        if let cardNumber = cardNumberTextField.text, let expireDate = expiryDateTextField.text, let cvcCode = cvcTextField.text, let cardHolderName = cardholderNameTextField.text {
//            self.userPaymentInfo = UserCardInfo(cardNumber: Int(cardNumber)!, expireDate: expireDate, cvc: Int(cvcCode)!, cardHolder: cardHolderName)
//        }
        
        self.navigationController?.pushViewController(FinishPaymentViewController(descriptionText: descriptionChoises[0]), animated: true)

        
    }
    
    @objc func segmentedControlValueChange(_ target: UISegmentedControl) {
        if target == paymentMethodsControl {
            let segmentIndex = target.selectedSegmentIndex

            if segmentIndex == 0 {
                self.cardPaymentView.isHidden = false
                self.cashPaymentView.isHidden = true
            } else if segmentIndex == 1 {
                self.cardPaymentView.isHidden = true
                self.cashPaymentView.isHidden = false
            }
        }
    }
    
    @objc func confirmButtonPressed(_ sender : UIButton) {
        confirmButtonStatus = !confirmButtonStatus
        if confirmButtonStatus {
            sender.setImage(UIImage(systemName: "square.fill"), for: .normal)
            sender.tintColor = UIColor.green
            reserveButton.isEnabled = true
            reserveButton.backgroundColor = .cellsBlueColor
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            sender.tintColor = UIColor.red
            reserveButton.isEnabled = false
            reserveButton.backgroundColor = .textUnavalibleGray
        }
    }
    
    @objc func reserveButtonTaped() {
        self.navigationController?.pushViewController(FinishPaymentViewController(descriptionText: descriptionChoises[1]), animated: true)
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(costTitle)
        view.addSubview(contentView)
        contentView.addSubview(methodsTitleLabel)
        contentView.addSubview(paymentMethodsControl)
        contentView.addSubview(cardPaymentView)
        cardPaymentView.addSubview(cardNumberLabel)
        cardPaymentView.addSubview(cardNumberTextField)
        cardPaymentView.addSubview(expiryDateLabel)
        cardPaymentView.addSubview(expiryDateTextField)
        cardPaymentView.addSubview(cvcLabel)
        cardPaymentView.addSubview(cvcTextField)
        cardPaymentView.addSubview(cardholderNameLabel)
        cardPaymentView.addSubview(cardholderNameTextField)
        cardPaymentView.addSubview(payNowButton)
        contentView.addSubview(cashPaymentView)
        cashPaymentView.addSubview(cashPaymentMainLabel)
        cashPaymentView.addSubview(aproovmentLabel)
        cashPaymentView.addSubview(confirmButton)
        cashPaymentView.addSubview(reserveButton)
    }
    
    private func configureSegmentedControl() {
        self.paymentMethodsControl = UISegmentedControl(items: paymentsVariationsArray)
        self.paymentMethodsControl.translatesAutoresizingMaskIntoConstraints = false
        self.paymentMethodsControl.addTarget(self, action: #selector(segmentedControlValueChange(_:)), for: .valueChanged)
        self.paymentMethodsControl.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont.averiaRegular15() ?? UIFont.systemFont(ofSize: 15),
             NSAttributedString.Key.foregroundColor : UIColor.black],
            for: .normal)
        self.paymentMethodsControl.selectedSegmentTintColor = .cellsBlueColor
        self.paymentMethodsControl.selectedSegmentIndex = 0
    }
    
    private func configureTextFields() {
        cardNumberTextField.delegate = self
        expiryDateTextField.delegate = self
        cvcTextField.delegate = self
        cardholderNameTextField.delegate = self
        cardholderNameTextField.keyboardType = .namePhonePad
    }
    
    private func addButtonsMethods() {
        payNowButton.addTarget(self, action: #selector(payNowButtonTaped), for: .touchUpInside)
        reserveButton.addTarget(self, action: #selector(reserveButtonTaped), for: .touchUpInside)
    }
    
    private func configureButtons() {
        reserveButton.isEnabled = false
        payNowButton.isEnabled = false
        reserveButton.backgroundColor = .textUnavalibleGray
        payNowButton.backgroundColor = .textUnavalibleGray
    }
    

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            costTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            costTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 190),
            
            contentView.topAnchor.constraint(equalTo: costTitle.bottomAnchor, constant: 69),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            methodsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            methodsTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            paymentMethodsControl.topAnchor.constraint(equalTo: methodsTitleLabel.bottomAnchor, constant: 20),
            paymentMethodsControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            paymentMethodsControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            paymentMethodsControl.heightAnchor.constraint(equalToConstant: 50),
            
            // CardPaymentView Section
            
            cardPaymentView.topAnchor.constraint(equalTo: paymentMethodsControl.bottomAnchor, constant: 20),
            cardPaymentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardPaymentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardPaymentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cardNumberLabel.topAnchor.constraint(equalTo: cardPaymentView.topAnchor),
            cardNumberLabel.leadingAnchor.constraint(equalTo: cardPaymentView.leadingAnchor, constant: 40),
            cardNumberTextField.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 10),
            cardNumberTextField.leadingAnchor.constraint(equalTo: cardPaymentView.leadingAnchor, constant: 40),
            cardNumberTextField.trailingAnchor.constraint(equalTo: cardPaymentView.trailingAnchor, constant: -40),
            expiryDateLabel.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 20),
            expiryDateLabel.leadingAnchor.constraint(equalTo: cardPaymentView.leadingAnchor, constant: 40),
            expiryDateTextField.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor, constant: 10),
            expiryDateTextField.leadingAnchor.constraint(equalTo: cardPaymentView.leadingAnchor, constant: 40),
            expiryDateTextField.widthAnchor.constraint(equalToConstant: 160),
            cvcLabel.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 20),
            cvcLabel.trailingAnchor.constraint(equalTo: cardPaymentView.trailingAnchor, constant: -100),
            cvcTextField.topAnchor.constraint(equalTo: cvcLabel.bottomAnchor, constant: 10),
            cvcTextField.trailingAnchor.constraint(equalTo: cardPaymentView.trailingAnchor, constant: -40),
            cvcTextField.widthAnchor.constraint(equalToConstant: 140),
            cardholderNameLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20),
            cardholderNameLabel.leadingAnchor.constraint(equalTo: cardPaymentView.leadingAnchor, constant: 40),
            cardholderNameTextField.topAnchor.constraint(equalTo: cardholderNameLabel.bottomAnchor, constant: 10),
            cardholderNameTextField.leadingAnchor.constraint(equalTo: cardPaymentView.leadingAnchor, constant: 40),
            cardholderNameTextField.trailingAnchor.constraint(equalTo: cardPaymentView.trailingAnchor, constant: -40),
            payNowButton.topAnchor.constraint(equalTo: cardholderNameTextField.bottomAnchor, constant: 15),
            payNowButton.leadingAnchor.constraint(equalTo: cardPaymentView.leadingAnchor, constant: 25),
            payNowButton.trailingAnchor.constraint(equalTo: cardPaymentView.trailingAnchor, constant: -25),
            
            // CardPaymentView Section
            
            cashPaymentView.topAnchor.constraint(equalTo: paymentMethodsControl.bottomAnchor, constant: 20),
            cashPaymentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cashPaymentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cashPaymentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cashPaymentMainLabel.topAnchor.constraint(equalTo: cashPaymentView.topAnchor, constant: 35),
            cashPaymentMainLabel.leadingAnchor.constraint(equalTo: cashPaymentView.leadingAnchor, constant: 20),
            cashPaymentMainLabel.trailingAnchor.constraint(equalTo: cashPaymentView.trailingAnchor, constant: -20),
            aproovmentLabel.topAnchor.constraint(equalTo: cashPaymentMainLabel.bottomAnchor, constant: 25),
            aproovmentLabel.leadingAnchor.constraint(equalTo: cashPaymentView.leadingAnchor, constant: 120),
            confirmButton.centerYAnchor.constraint(equalTo: aproovmentLabel.centerYAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: aproovmentLabel.trailingAnchor, constant: 20),
            reserveButton.leadingAnchor.constraint(equalTo: cashPaymentView.leadingAnchor, constant: 25),
            reserveButton.trailingAnchor.constraint(equalTo: cashPaymentView.trailingAnchor, constant: -25),
            reserveButton.bottomAnchor.constraint(equalTo: cashPaymentView.bottomAnchor, constant: -35),
        ])
    }
    
}

// MARK: - UITextfield Delegate

extension PaymentViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == expiryDateTextField {
            let dateMask = Veil(pattern: "## / ## / ####")
            
            if let currentText = textField.text {
                textField.text = dateMask.mask(input: currentText, exhaustive: false)
            }
        } else if textField == cardNumberTextField {
            let dateMask = Veil(pattern: "#### #### #### ####")
            
            if let currentText = textField.text {
                textField.text = dateMask.mask(input: currentText, exhaustive: false)
            }
        } else if textField == cvcTextField {
            let dateMask = Veil(pattern: "###")
            
            if let currentText = textField.text {
                textField.text = dateMask.mask(input: currentText, exhaustive: false)
            }
        }
        
        
        if cardNumberTextField.text!.count == 19 && expiryDateTextField.text!.count == 14 &&  cvcTextField.text!.count == 3 && cardholderNameTextField.text != "" {
            self.payNowButton.isEnabled = true
            self.payNowButton.backgroundColor = .cellsBlueColor
        } else {
            self.payNowButton.isEnabled = false
            self.payNowButton.backgroundColor = .textUnavalibleGray
        }
        
        return true
    }
    
}

