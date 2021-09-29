//
//  ServiceMockCell.swift
//  iCar
//
//  Created by Dafle Cardoso on 06/09/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class ServiceMockCell: UITableViewCell {
    
    private let defaultTintColor = MockServices.shared.style.tintColor
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(12)
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        backgroundColor = .clear
        let selectedView = UIView()
        selectedView.backgroundColor = defaultTintColor
        selectedView.layer.cornerRadius = 8
        selectedBackgroundView = selectedView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let textColor: UIColor = selected ? .white : defaultTintColor
        iconImageView.tintColor = textColor
        titleLabel.textColor = textColor
        print(selected)
    }
    
    private func setupConstraints() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        let imageHeight: CGFloat = 16
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            iconImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).apply { $0.priority = .defaultLow },
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func set(with item: ServiceMockApis) {
        titleLabel.text = item.title
        iconImageView.image = item.icon
    }
}
