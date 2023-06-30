import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    let categoryCellLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular20()
        lb.textColor = .white
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
        contentView.backgroundColor = .cellsBlueColor
        contentView.layer.cornerRadius = 10
        contentView.addSubview(categoryCellLabel)
        categoryCellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        categoryCellLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
}
