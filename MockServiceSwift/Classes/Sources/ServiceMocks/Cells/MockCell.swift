//
//  MocksCell.swift
//  MockServiceSwift
//
//  Created by Dafle on 29/09/21.
//

import Foundation
import UIKit

class MockCell: UICollectionViewCell {
    
    private let defaultTintColor = MockServices.shared.style.tintColor
    private let margin: CGFloat = 16
    
    let statusCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(12)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(10)
        label.textColor = .warmGrey
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            statusCodeLabel,
            descriptionLabel,
            UIView()
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
        
    var arrowImage: UIImage? {
        return UIImage(named: "ic_arrow_right", in: MockServices.bundle, compatibleWith: nil)
    }
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(arrowImage, for: .normal)
        let buttonWidth: CGFloat = 26
        button.layer.cornerRadius = buttonWidth / 2
        button.backgroundColor = .arrowBackgroundColor
        button.imageEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.addTarget(self, action: #selector(didTapArrowButton), for: .touchUpInside)
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cardColor
        return view
    }()
    
    @objc private func didTapTwoTimesCardView() {
        seeDetailsTapped?()
    }
    
    var seeDetailsTapped: (() -> Void)?

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
      //  containerView.addSubview(radioButton)
        containerView.addSubview(arrowButton)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            arrowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            arrowButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }
    
    func set(with mock: ResponseMock) {
        statusCodeLabel.text = String(mock.statusCode)
        statusCodeLabel.textColor = mock.statusCodeColor
        descriptionLabel.text = mock.description
    }
    
    @objc private func didTapArrowButton() {
        seeDetailsTapped?()
    }
}
