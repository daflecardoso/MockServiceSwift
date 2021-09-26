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
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show mock area", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapShowButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(showButton)
        
        NSLayoutConstraint.activate([
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("start 😀")
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if let data = value as? Data {
                if let str = String(data: data, encoding: .utf8) {
                    print("\(key) = \(str) \n")
                }
                
            }
        }
        print("end 😀")
    }
    
    @objc private func didTapShowButton() {
        
        let style = MockServices.Style(tintColor: .systemBlue)
        
        let services = [
            ServiceMockApis(
                title: "fooAPI",
                color: .systemBlue,
                icon: UIImage(named: "ic_bug")?.withRenderingMode(.alwaysTemplate),
                apis: FooAPI.apis
            ),
            ServiceMockApis(
                title: "barAPI",
                color: .systemRed,
                icon:  UIImage(named: "ic_bug")?.withRenderingMode(.alwaysTemplate),
                apis: []
            )
        ]
        
        let mockService = MockServices.shared
            .setStyle(style)
            .services(services)
        
        
        mockService.didChangeMock = { [weak self] mock in
            print("key", mock.key)
            print("isEnabled", mock.isEnabled)
            print("selected file", mock.items.first(where: { $0.isSelected })?.fileName ?? "nil")
            print("\n\n")
        }
        
         let viewController =  mockService.makeMocksViewController()
        
        let navigation = UINavigationController(rootViewController: viewController)
      //  navigation.modalPresentationStyle = .overFullScreen
        present(navigation, animated: true, completion: nil)
    }
}

