import UIKit

final class MessageTableViewCell: UITableViewCell {
    
     let bubleView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     let messageText : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular15()
        lb.numberOfLines = 0
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        bubleView.layer.cornerRadius = bubleView.frame.size.height / 5
        self.backgroundColor = .clear
        configure()
        NSLayoutConstraint.activate([
            bubleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bubleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageText.centerXAnchor.constraint(equalTo: bubleView.centerXAnchor),
            messageText.centerYAnchor.constraint(equalTo: bubleView.centerYAnchor)
        ])
    }

    private func configure() {
        contentView.addSubview(bubleView)
        bubleView.addSubview(messageText)
    }
    
     func senderIsMe(messageText text: String) {
        bubleView.backgroundColor = .cellsBlueColor
        messageText.textColor = .white
        messageText.text = text
        
        NSLayoutConstraint.activate([
            bubleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bubleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 140)
        ])
    }
    
     func senderIsDoctor(messageText text: String) {
        bubleView.backgroundColor = .textUnavalibleGray
        messageText.textColor = .black
        messageText.text = text
        
        NSLayoutConstraint.activate([
            bubleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -140),
            bubleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
}
