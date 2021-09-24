//
//  EndPointMocksViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class EndPointMocksViewController: UIViewController {
    
    private let viewModel: EndPointMocksViewModel
    
    private let cell = EndPointMocksCell.self
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cell, forCellReuseIdentifier: cell.className)
        tableView.backgroundColor = .clear
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Novo mock", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapAddButton() {
        self.navigateToDetails(mock: nil)
    }
    
    init(viewModel: EndPointMocksViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch()
    }
    
    private func setup() {
        setupView()
        setupTableView()
        setupBinds()
    }
    
    private func setupBinds() {
        viewModel.reload = { [unowned self] in
            tableView.reloadData()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundContainerViews
        navigationItem.titleView = UILabel.title(viewModel.endpoint.pathFormated)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }
    
    private func navigateToDetails(mock: MockType?) {
        let viewController = makeAddEditMockViewController(endpoint: viewModel.endpoint, mock: mock)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func makeAddEditMockViewController(endpoint: MockTargetEndpoint, mock: MockType?) -> AddEditMockViewController {
        let viewModel = AddEditMockViewModel(endpoint: endpoint, mock: mock)
        return AddEditMockViewController(viewModel: viewModel)
    }
}

extension EndPointMocksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        viewModel.didTapEndPoint(selectedItem: item)
    }
}

extension EndPointMocksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! EndPointMocksCell
        cell.set(with: item)
        cell.deleteTapped = { [unowned self] in
            viewModel.delete(item: item)
        }
         
        cell.seeDetailsTapped = { [unowned self] in
            self.navigateToDetails(mock: item)
        }
        return cell
    }
}
