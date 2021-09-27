//
//  ViewController.swift
//  MockServiceSwift
//
//  Created by daflecardoso on 09/24/2021.
//  Copyright (c) 2021 daflecardoso. All rights reserved.
//

import UIKit
import MockServiceSwift

class ViewController: UIViewController {
    
    private let network = MyNetwork()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show mock area", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapShowButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var callApiButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call API", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapCallAPI), for: .touchUpInside)
        return button
    }()
    
    private lazy var responseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(showButton)
        view.addSubview(callApiButton)
        view.addSubview(responseLabel)
        
        NSLayoutConstraint.activate([
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            callApiButton.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 16),
            callApiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            responseLabel.topAnchor.constraint(equalTo: callApiButton.bottomAnchor, constant: 16),
            responseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            responseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func didTapShowButton() {
        
        let apis = [
            FooAPI.self
        ]
        
        let services = apis.map {
            ServiceMockApis(
                title: String(describing: $0),
                color: .systemBlue,
                icon: UIImage(named: "ic_bug")?.withRenderingMode(.alwaysTemplate),
                apis: $0.apis)
        }
        
        let viewController = MockServices.shared
            .setStyle(MockServices.Style(tintColor: .systemBlue))
            .services(services)
            .makeMocksViewController()
        
        let navigation = UINavigationController(rootViewController: viewController)
        present(navigation, animated: true, completion: nil)
    }
    
    @objc private func didTapCallAPI() {
        
        network.foo { [unowned self] response in
            self.responseLabel.text = response
            print(response)
        } failure: { error in
            print("some error")
        }
    }
}

