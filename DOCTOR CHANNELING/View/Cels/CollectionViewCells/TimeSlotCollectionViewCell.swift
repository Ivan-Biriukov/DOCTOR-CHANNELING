import UIKit

class TimeSlotCollectionViewCell: UICollectionViewCell {
    
    let timeLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular20()
        lb.textColor = .black
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
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
        contentView.layer.cornerRadius = 10
        contentView.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
}
