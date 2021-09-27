//
//  EndPointMocksCell.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class EndPointMocksCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(14)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(12)
        label.numberOfLines = 0
        label.textColor = .warmGrey
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            descriptionLabel,
            UIStackView(arrangedSubviews: [
                seeDetailsButton, UIView()
            ]).apply(closure: { stck in
                stck.axis = .horizontal
            })
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let radioButton: RadioButton = {
        let button = RadioButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.tintColor = MockServices.shared.style.tintColor
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    let seeDetailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(MockServices.shared.style.tintColor, for: .normal)
        button.titleLabel?.font = .bold(12)
        button.setTitle("detalhes", for: .normal)
        button.addTarget(self, action: #selector(didTapSeeDetails), for: .touchUpInside)
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [seeDetailsButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    var seeDetailsTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        let margin: CGFloat = 16
        contentView.addSubview(stackView)
        contentView.addSubview(radioButton)
        
        contentView.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            
            radioButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func set(with api: ResponseMock) {
        nameLabel.text = api.name
        descriptionLabel.text = api.description
    }
    
    @objc private func didTapSeeDetails() {
        seeDetailsTapped?()
    }
}
