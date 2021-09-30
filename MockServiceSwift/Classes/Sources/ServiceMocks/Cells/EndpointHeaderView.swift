//
//  EndpointHeaderView.swift
//  MockServiceSwift
//
//  Created by Dafle on 29/09/21.
//

import Foundation

class EndpointHeaderView: UICollectionReusableView {
    
    private let defaultTintColor = MockServices.shared.style.tintColor
    
    private let methodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(12)
        return label
    }()
    
    private let statusTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(12)
        return label
    }()
    
    private let pathLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(10)
        label.textColor = .warmGrey
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                methodLabel,
                statusTitleLabel,
                UIView()
            ]).apply {
                $0.axis = .horizontal
                $0.spacing = 4
            },
            pathLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var swt: UISwitch = {
        let swt = UISwitch()
        swt.translatesAutoresizingMaskIntoConstraints = false
        swt.onTintColor = defaultTintColor
        swt.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        return swt
    }()
    
    var switchChanged: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        addSubview(swt)
        
        backgroundColor = .backgroundContainerViews
        
        let margins: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor).apply {
                $0.priority = .defaultLow
            },
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            swt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margins),
            swt.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }
    
    func set(with item: EndpointMock) {
        methodLabel.text = item.mockMethod
        methodLabel.textColor = item.methodColor
        statusTitleLabel.text = item.description
        pathLabel.text = item.mockPath
        swt.isOn = item.isEnabled
    }
    
    @objc private func didChangeSwitch() {
        switchChanged?()
    }
}
