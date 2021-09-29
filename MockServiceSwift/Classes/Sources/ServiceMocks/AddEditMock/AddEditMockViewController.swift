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
    
    private lazy var responseField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autocorrectionType = .no
        textView.attributedText = viewModel.attributedJson
        textView.keyboardDismissMode = .interactive
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    private let viewModel: AddEditMockViewModel
    
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
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundContainerViews
        navigationItem.titleView = UILabel.title(viewModel.mockItem.description)
    }
    
    private func setupConstraints() {
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
    
    deinit {
        print("\(self) deinitialized")
    }
}
