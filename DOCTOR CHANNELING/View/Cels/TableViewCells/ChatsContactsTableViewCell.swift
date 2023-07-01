import UIKit

class ChatsContactsTableViewCell: UITableViewCell {

     var data : ChatWithDoctorModel? {
         didSet {
             self.doctorImage.image = data?.doctorAvatar
             self.doctorNameLabel.text = data?.chatHistory?.contactName
             self.lastMessageTimeLabel.text = data?.chatHistory?.lastMessageTime
             self.lastMessageTextlabel.text = data?.chatHistory?.lastMessage
         }
     }
        
     let doctorImage : UIImageView = {
         let img = UIImageView()
         img.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
         img.contentMode = .scaleAspectFit
         img.translatesAutoresizingMaskIntoConstraints = false
         return img
     }()
     
     let doctorNameLabel : UILabel = {
         let lb = UILabel()
         lb.font = .averiaRegular20()
         lb.textColor = .black
         lb.textAlignment = .left
         lb.translatesAutoresizingMaskIntoConstraints = false
         return lb
     }()
    
    let lastMessageTimeLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular12()
        lb.textColor = .black
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let lastMessageTextlabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular12()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
     let unreadedMessageIndicatorView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .cellsBlueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     let unreadedMessageCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     private func configure() {
         backgroundColor = .lightGrayBackgroundColor
         layer.cornerRadius = 10
         contentView.addSubview(doctorImage)
         contentView.addSubview(doctorNameLabel)
         contentView.addSubview(lastMessageTimeLabel)
         contentView.addSubview(lastMessageTextlabel)
         contentView.addSubview(unreadedMessageIndicatorView)
         unreadedMessageIndicatorView.addSubview(unreadedMessageCountLabel)

         NSLayoutConstraint.activate([
            doctorImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11.5),
            doctorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            doctorImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11.5),
            doctorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            doctorNameLabel.leadingAnchor.constraint(equalTo: doctorImage.trailingAnchor, constant: 27),
            lastMessageTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            lastMessageTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            lastMessageTextlabel.topAnchor.constraint(equalTo: doctorNameLabel.bottomAnchor, constant: 11),
            lastMessageTextlabel.leadingAnchor.constraint(equalTo: doctorImage.trailingAnchor, constant: 27),
            unreadedMessageIndicatorView.topAnchor.constraint(equalTo: lastMessageTimeLabel.bottomAnchor, constant: 26),
            unreadedMessageIndicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            unreadedMessageCountLabel.centerXAnchor.constraint(equalTo: unreadedMessageIndicatorView.centerXAnchor),
            unreadedMessageCountLabel.centerYAnchor.constraint(equalTo: unreadedMessageIndicatorView.centerYAnchor)
         ])
     }
}
