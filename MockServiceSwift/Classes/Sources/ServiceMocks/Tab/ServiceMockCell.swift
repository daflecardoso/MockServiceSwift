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
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        iconImageView,
        titleLabel
    ]).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
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
        backgroundColor = .clear
        let selectedView = UIView()
        selectedView.backgroundColor = defaultTintColor
        selectedView.layer.cornerRadius = 8
        selectedBackgroundView = selectedView
    }
    
    override var isSelected: Bool {
        didSet {
            setupColors()
        }
    }
    
    private func setupConstraints() {
        contentView.addSubview(stackView)
       
        
        let imageHeight: CGFloat = 16
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            iconImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).apply { $0.priority = .defaultLow }
        ])
    }
    
    func set(with item: ServiceMockApis, index: Int) {
        titleLabel.text = "\(index) - " + item.title
        iconImageView.isHidden = item.icon == nil
        iconImageView.image = item.icon
        setupColors()
    }
    
    private func setupColors() {
        let textColor: UIColor = isSelected ? .white : defaultTintColor
        iconImageView.tintColor = textColor
        titleLabel.textColor = textColor
        // print("isSelected", isSelected)
    }
}
