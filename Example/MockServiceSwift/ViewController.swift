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
    
    @objc private func didTapShowButton() {
        
        let viewController = MockServices.shared.makeMocksViewController(services: [
            ServiceMockApis(
                title: "fooAPI",
                color: .red,
                icon: UIImage(named: "ic_bug")?.withRenderingMode(.alwaysTemplate),
                apis: FooAPI.cases
            ),
            ServiceMockApis(
                title: "barAPI",
                color: .blue,
                icon:  UIImage(named: "ic_bug")?.withRenderingMode(.alwaysTemplate),
                apis: BarAPI.cases
            )
        ])
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .overFullScreen
        present(navigation, animated: true, completion: nil)
    }
}

