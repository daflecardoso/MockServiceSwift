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
        label.numberOfLines = 0
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
        label.numberOfLines = 0
        return label
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .bold(12)
        button.setTitleColor(MockServices.shared.style.tintColor, for: .normal)
        button.setTitle("Reset", for: .normal)
        if #available(iOS 11.0, *) {
            button.contentHorizontalAlignment = .leading
        } else {
            button.contentHorizontalAlignment = .left
        }
        button.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        return button
    }()
    
    lazy var switchMock: UISwitch = {
        let swt = UISwitch()
        swt.translatesAutoresizingMaskIntoConstraints = false
        swt.onTintColor = MockServices.shared.style.tintColor
        swt.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        return swt
    }()
    
    private lazy var stackSwitch = UIStackView(arrangedSubviews: [
        resetButton,
        switchMock
    ]).apply {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            methodLabel,
            userNameLabel,
            descriptionLabel,
            countMocks,
            stackSwitch
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
    
    var resetButtonTapped: (() -> Void)?

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
            }
        ])
    }
    
    func set(with api: MockTargetEndpoint) {
        methodLabel.text = api.requestMethod
        userNameLabel.text = api.pathFormated
        descriptionLabel.text = api.description
        switchMock.isOn = api.mockIsOn
        containerView.backgroundColor =  api.mockIsOn
            ? MockServices.shared.style.tintColor.withAlphaComponent(0.3)
            : UIColor.headerNavigationTint
        countMocks.text = "\(api.currentAPIMock?.items.count ?? 0) mocks"
    }
    
    @objc private func didChangeSwitch() {
        switchChanged?()
    }
    
    @objc private func didTapResetButton() {
        resetButtonTapped?()
    }
}
