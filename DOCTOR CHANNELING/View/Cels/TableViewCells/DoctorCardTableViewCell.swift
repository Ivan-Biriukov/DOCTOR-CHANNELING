import UIKit

class DoctorCardTableViewCell: UITableViewCell {
    
    private var isLikeButtonTaped : Bool = false
    
    var data : DoctorCardModel? {
        didSet {
            self.doctorImage.image = data?.imgae
            self.doctorNameLabel.text = data?.name
            self.doctorDescriptionLabel.text = data?.description
            self.doctorRatingLabel.text = data?.raiting
        }
    }
    
    let doctorImage : UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: 0, y: 0, width: 140, height: 154)
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
    
    lazy var likeButton : UIButton = {
        let like = UIButton()
        like.setTitle(nil, for: .normal)
        like.setImage(UIImage(systemName: "heart"), for: .normal)
        like.tintColor = .cellsBlueColor
        like.addTarget(self, action: #selector(buttonTaped(_:)), for: .touchUpInside)
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    private let firstLaneStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let doctorDescriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular12()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var bookButton = ReusableUIButton(style: .book, title: "Book")
    
    let starIcon : UIImageView = {
        let star = UIImageView(image: UIImage(systemName: "star.fill"))
        star.tintColor = .uiGold
        star.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        star.translatesAutoresizingMaskIntoConstraints = false
        return star
    }()
    
    let doctorRatingLabel : UILabel = {
        let lb = UILabel()
        lb.font = .averiaRegular16()
        lb.textColor = .black
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let ratingStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let lastLineStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let rightSideStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    

    private func configure() {
        bookButton.addTarget(self, action: #selector(buttonTaped(_:)), for: .touchUpInside)
        backgroundColor = .lightGrayBackgroundColor
        layer.cornerRadius = 10
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(doctorImage)
        mainStackView.addArrangedSubview(rightSideStack)
        rightSideStack.addArrangedSubview(firstLaneStack)
        firstLaneStack.addArrangedSubview(doctorNameLabel)
        firstLaneStack.addArrangedSubview(likeButton)
        rightSideStack.addArrangedSubview(doctorDescriptionLabel)
        rightSideStack.addArrangedSubview(lastLineStack)
        lastLineStack.addArrangedSubview(bookButton)
        lastLineStack.addArrangedSubview(ratingStack)
        ratingStack.addArrangedSubview(starIcon)
        ratingStack.addArrangedSubview(doctorRatingLabel)
        
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            bookButton.widthAnchor.constraint(equalToConstant: 80),
            bookButton.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTaped(_ sender: UIButton) {
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        
        if sender == likeButton {
            isLikeButtonTaped = !isLikeButtonTaped
            if isLikeButtonTaped {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        } else if sender == bookButton {
            
        }
    }
    
}
