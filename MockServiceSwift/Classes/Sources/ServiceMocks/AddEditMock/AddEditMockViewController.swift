//
//  AddEditMockViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class AddEditMockViewController: BaseViewController {
    
    let margin: CGFloat = 16
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let font: UIFont = .regularMenlo(14)
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5000
        label.font = font
        return label
    }
    
    private lazy var linesLabel: UILabel = {
        let label = makeLabel()
        label.textColor = UIColor(red: 93/255, green: 114/255, blue: 166/255, alpha: 1.0)
        label.text = viewModel.lines
        return label
    }()
    
    private lazy var labelJson: UILabel = {
        let label = makeLabel()
        label.attributedText = viewModel.json.makeJsonAttributed()
        return label
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
        view.addSubview(scrollView)
        scrollView.addSubview(labelJson)
        scrollView.addSubview(linesLabel)
        NSLayoutConstraint.activate([

            scrollView.topAnchor
                .constraint(equalTo: view.topAnchor, constant: margin),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            linesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            linesLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            linesLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            labelJson.topAnchor.constraint(equalTo: scrollView.topAnchor),
            labelJson.leadingAnchor.constraint(equalTo: linesLabel.trailingAnchor, constant: 10),
            labelJson.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            labelJson.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    deinit {
        print("\(self) deinitialized")
    }
}
