
import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    var contentData : InfoCollectionDataModel? {
        didSet {
            mainTitle.text = contentData?.mainTitleText
            descriptionLabel.text = contentData?.descriptionText
            contentImage.image = contentData?.contentImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainTitle : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular26()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let descriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular16()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let contentImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private func configure() {
        contentView.backgroundColor = .cellsBlueColor
        contentView.layer.cornerRadius = 10
        contentView.addSubview(mainTitle)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(contentImage)
    
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.92),
            mainTitle.trailingAnchor.constraint(equalTo: contentImage.leadingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.92),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentImage.leadingAnchor, constant: -10),
            
            contentImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentImage.heightAnchor.constraint(equalToConstant: 170),
            contentImage.widthAnchor.constraint(equalToConstant: 140),
            
        ])
    }
}
