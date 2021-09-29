//
//  MocksViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

public class ServicesMocksViewController: UIViewController {
    
    private let defaultTintColor = MockServices.shared.style.tintColor
    
    private let viewModel: ServicesMocksViewModel
    
    private let cell = ServiceMockCell.self
    
    private let mockCell = MockCell.self
    
    private let collectionViewHeader = EndpointHeaderView.self
    
    lazy var servicesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cell, forCellReuseIdentifier: cell.className)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let spacing: CGFloat = 8
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.scrollDirection = .vertical
            let width = UIScreen.main.bounds.width - 100
            layout.headerReferenceSize = CGSize(width: width, height: 40)
            let screenWidth = width
            let itemCount: CGFloat = 2
            let inset = (spacing * (itemCount - 1))
            let totalMargins: CGFloat = ((itemCount - 1) * spacing) + (spacing * 2) + inset
            let screenWidthWithoutSpaces = screenWidth - totalMargins
            let itemWidth: CGFloat = screenWidthWithoutSpaces / itemCount
            let itemSize = CGSize(width: itemWidth, height: 100)
            layout.itemSize = itemSize
            layout.sectionInset.bottom = 24
            layout.sectionInset.top = spacing
            layout.sectionInset.left = spacing
            layout.sectionInset.right = spacing
            layout.sectionHeadersPinToVisibleBounds = true
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(mockCell, forCellWithReuseIdentifier: String(describing: mockCell))
        collectionView.register(collectionViewHeader,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: collectionViewHeader.className)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    public init(viewModel: ServicesMocksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        selectRow(row: 0)
    }
    
    private func selectRow(row: Int) {
        let indexPath = IndexPath(row: 0, section: 0)
        didSelectMenu(indexPath: indexPath)
        servicesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
    
    private func setup() {
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        navigationItem.titleView = UILabel.title("Mocks")
        view.backgroundColor = .backgroundContainerViews
    }
    
    private func setupTableView() {
        view.addSubview(servicesTableView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            servicesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            servicesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            servicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            servicesTableView.widthAnchor.constraint(equalToConstant: 100),
            
            collectionView.leadingAnchor.constraint(equalTo: servicesTableView.trailingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: servicesTableView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: servicesTableView.bottomAnchor),
        ])
    }
    
    func makeAddEditMockViewController(endpoint: EndpointMock, mock: ResponseMock) -> AddEditMockViewController {
        let viewModel = AddEditMockViewModel(endpoint: endpoint, mock: mock)
        return AddEditMockViewController(viewModel: viewModel)
    }
    
    private func navigateToDetails(endpoint: EndpointMock, mock: ResponseMock) {
        let viewController = makeAddEditMockViewController(endpoint: endpoint, mock: mock)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func didSelectMenu(indexPath: IndexPath)  {
        let item = viewModel.services[indexPath.row]
        viewModel.select(service: item)
        collectionView.reloadData()
    }
    
    deinit {
        print("\(self) deinitialized")
    }
}

extension ServicesMocksViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectMenu(indexPath: indexPath)
    }
}

extension ServicesMocksViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.services.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.services[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cell.className, for: indexPath) as! ServiceMockCell
        cell.set(with: item)
        return cell
    }
}


extension ServicesMocksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: collectionViewHeader.className,
                                                  for: indexPath) as! EndpointHeaderView
            let item = viewModel.apis[indexPath.section]
            headerView.set(with: item)
            headerView.switchChanged = { [unowned self] in
                self.viewModel.toggle(item: item, isOn: headerView.swt.isOn)
                self.collectionView.reloadItems(at: [indexPath])
            }
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: collectionViewHeader.className, for: indexPath)
            
            footerView.backgroundColor = UIColor.green
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.apis.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.apis[section].mocks.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let endpoint = viewModel.apis[indexPath.section]
        let item = endpoint.mocks[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mockCell.className, for: indexPath) as! MockCell
        
        let isSelected = viewModel.isSelected(item: item, endpoint: endpoint)
        let color: UIColor = isSelected ? defaultTintColor : .headerNavigationTint
        let shadowColor: UIColor = isSelected ? defaultTintColor : .gray
        cell.set(with: item)
        cell.radioButton.isChecked = isSelected
        cell.containerView.setupShadowBorder(borderColor: color, shadowColor: shadowColor)
        cell.seeDetailsTapped = { [unowned self] in
            self.navigateToDetails(endpoint: endpoint, mock: item)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let endpoint = viewModel.apis[indexPath.section]
        let item = endpoint.mocks[indexPath.row]
        viewModel.didTapMock(selectedItem: item, endpoint: endpoint)
        collectionView.reloadSections(IndexSet(integer: indexPath.section))
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.reloadData()
    }
}
