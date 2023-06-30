import UIKit

class ActiveNowChatCollectionViewCell: UICollectionViewCell {
    
    let doctorAvatar : UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let onlineIndicator : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        view.layer.cornerRadius = 7.5
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.backgroundColor = .lightGrayBackgroundColor
        contentView.layer.cornerRadius = 30
        contentView.addSubview(doctorAvatar)
        contentView.addSubview(onlineIndicator)
        
        NSLayoutConstraint.activate([
            doctorAvatar.topAnchor.constraint(equalTo: contentView.topAnchor),
            doctorAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            doctorAvatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            doctorAvatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            onlineIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            onlineIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            onlineIndicator.widthAnchor.constraint(equalToConstant: 15),
            onlineIndicator.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func changeDoctorStatus(doctorStatus : Bool) {
        if doctorStatus {
            onlineIndicator.backgroundColor = .systemGreen
        } else {
            onlineIndicator.backgroundColor = .systemRed
        }
    }
}
