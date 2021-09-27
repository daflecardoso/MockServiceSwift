//
//  MockAPICell.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class TargetMocksCell: UICollectionViewCell {
    
    private let margin: CGFloat = 16
    
    private let methodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(14)
        label.numberOfLines = 0
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(14)
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(12)
        label.textColor = .warmGrey
        label.numberOfLines = 2
        return label
    }()
    
    private let countMocks: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(12)
        label.textColor = .warmGrey
        return label
    }()
    
    lazy var switchMock: UISwitch = {
        let swt = UISwitch()
        swt.translatesAutoresizingMaskIntoConstraints = false
        swt.onTintColor = MockServices.shared.style.tintColor
        swt.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        return swt
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            methodLabel,
            userNameLabel,
            descriptionLabel,
            countMocks
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 16
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    var switchChanged: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupContentView()
        setupConstraints()
    }
    
    private func setupContentView() {
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.addSubview(switchMock)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8).apply {
                $0.priority = .defaultLow
            },
            
            switchMock.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            switchMock.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }
    
    func set(with api: EndpointMock) {
        methodLabel.text = api.mockMethod
        userNameLabel.text = api.mockPath
        descriptionLabel.text = api.description
        
        let isEnabled = api.isEnabled
        let containerColor = isEnabled
           ? MockServices.shared.style.tintColor.withAlphaComponent(0.3)
           : UIColor.headerNavigationTint
        switchMock.isOn = isEnabled
        containerView.backgroundColor =  containerColor
        countMocks.text = "\(api.mocks.count) mocks"
    }
    
    @objc private func didChangeSwitch() {
        switchChanged?()
    }
}
