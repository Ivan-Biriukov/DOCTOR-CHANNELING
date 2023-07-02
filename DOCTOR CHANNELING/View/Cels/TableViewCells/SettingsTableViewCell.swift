//
//  SettingsTableViewCell.swift
//  DOCTOR CHANNELING
//
//  Created by иван Бирюков on 02.07.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var cellData : SettingsDataModel? {
        didSet {
            self.cellImage.image = cellData?.image
            self.cellTitle.text = cellData?.title
        }
    }
    
    private let cellImage : UIImageView = {
        let image = UIImageView()
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let cellTitle : UILabel = {
        let title = UILabel()
        title.font = .averiaRegular20()
        title.textColor = .black
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(cellImage)
        contentView.addSubview(cellTitle)
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            cellTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cellTitle.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 30)
        ])
    }
}
