//
//  ServiceMockCell.swift
//  iCar
//
//  Created by Dafle Cardoso on 06/09/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class ServiceMockCell: UICollectionViewCell {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
        
        contentView.layer.cornerRadius = 8
    }
    
    private func setupConstraints() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func set(with item: ServiceMockApis) {
        titleLabel.text = item.title
        titleLabel.textColor = item.color
        iconImageView.image = item.icon
        iconImageView.tintColor = item.color
        contentView.backgroundColor = item.color.withAlphaComponent(0.2)
    }
}
