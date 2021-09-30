//
//  ViewController.swift
//  MockServiceSwift
//
//  Created by daflecardoso on 09/24/2021.
//  Copyright (c) 2021 daflecardoso. All rights reserved.
//

import UIKit
import MockServiceSwift
import Moya

class ViewController: UIViewController {
    
    private let network = MyNetwork()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show mock area", for: .normal)
        button.backgroundColor = .systemBlue
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white.withAlphaComponent(0.6), for: .highlighted)
        button.addTarget(self, action: #selector(didTapShowButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var callApiButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call API", for: .normal)
        button.backgroundColor = .systemBlue
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.layer.cornerRadius = 8
        button.setTitleColor(.systemBlue.withAlphaComponent(0.6), for: .highlighted)
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
        
        let apis: [EndpointMock.Type] = [
            GitHub.self,
            FooBiggerNameToTestAPI.self,
            BarAPI.self,
            GitHub.self,
            FooBiggerNameToTestAPI.self,
            BarAPI.self
        ]
        
        let services = apis.map {
            ServiceMockApis(
                title: String(describing: $0),
                icon: UIImage(named: "ic_bug")?.withRenderingMode(.alwaysTemplate),
                apis: $0.apis
            )
        }
        
        let viewController = MockServices.shared
            .setStyle(MockServices.Style(tintColor: .systemBlue))
            .services(services)
            .makeMocksViewController()
        
        let navigation = UINavigationController(rootViewController: viewController)
        present(navigation, animated: true, completion: nil)
    }
    
    @objc private func didTapCallAPI() {
        
//        network.foo { [unowned self] response in
//            self.responseLabel.text = response
//            print(response)
//        } failure: { error in
//            print("some error")
//        }
        callAPI()
    }
    
    @objc private func callAPI() {
        
        let service = MyMoyaExampleNetwork()
        
        service.gitHubUserProfile { event in
            switch event {
            case let .success(response):
                let data = response.data
                let json = String(data: data, encoding: .utf8) ?? "nil"
                self.responseLabel.text = json
            case let .failure(error):
                print(error)
            }
        }
    }
}

