//
//  AddEditMockViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class AddEditMockViewController: UIViewController {
    
    let margin: CGFloat = 16
    
//    private lazy var nameField: IcarTextField = {
//        let field = IcarTextField.build()
//        field.placeholderTitle = "Nome"
//        field.text = viewModel.mockItem?.name
//        field.isEnabled = false
//        return field
//    }()
    
    private lazy var responseField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autocorrectionType = .no
        let json = viewModel.mockItem?.data.prettyPrintedJSONString as String?
        textView.attributedText = (json ?? "").makeJsonAttributed()
        textView.keyboardDismissMode = .interactive
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.setTitle("Salvar", for: .normal)
        button.backgroundColor = MockServices.shared.style.tintColor
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()

    private let viewModel: AddEditMockViewModel
    
//    private lazy var bottomScrollConstraint
        //= scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
//
//    override var bottomConstraint: NSLayoutConstraint {
//        bottomScrollConstraint
//    }
//
    init(viewModel: AddEditMockViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
        setupBinds()
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundContainerViews
        navigationItem.titleView = UILabel.title(viewModel.title)
    }
    
    private func setupConstraints() {
//        view.addSubview(nameField) {
//            $0.top.leading.trailing.equalToSuperview().inset(margin)
//        }
        
        view.addSubview(responseField)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                responseField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                responseField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                responseField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                responseField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                responseField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                responseField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                responseField.topAnchor.constraint(equalTo: view.topAnchor),
                responseField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    @objc private func didTapSendButton() {
        viewModel.request(request: self.makeRequest())
    }
    
    private func setupBinds() {
//        nameField.rx.controlEvent(.allEvents).startWith(())
//            .map { [unowned self] _ in self.makeRequest().isValid }
//            .startWith(false)
//            .bind(to: sendButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        viewModel.saved = { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func makeRequest() -> MockType {
        return MockType(
            id: Date().yyyyMMddHHmmssii,
            isEnabled: false,
            name: "",
            description: "",
            data: responseField.text.data(using: .utf8) ?? Data()
        )
    }
}
