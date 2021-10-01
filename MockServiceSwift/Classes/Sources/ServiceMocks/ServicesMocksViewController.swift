//
//  MocksViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

public class ServicesMocksViewController: BaseViewController {
    
    private let defaultTintColor = MockServices.shared.style.tintColor
    
    private let viewModel: ServicesMocksViewModel
    
    private let mockCell = MockCell.self
    
    private let collectionViewHeader = EndpointHeaderView.self
    
    private var indexPath = MockServices.shared.getLatest()
    
    private lazy var tabView: ServiceTabsView = {
        let view = ServiceTabsView(services: viewModel.services)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didSelectMenu = { [unowned self] indexPath in
            self.indexPath = indexPath
            MockServices.shared.saveLatestViewed(row: indexPath.row)
            self.didSelectMenu(indexPath: indexPath)
        }
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let spacing: CGFloat = 8
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.scrollDirection = .vertical
            let width = UIScreen.main.bounds.width
            layout.headerReferenceSize = CGSize(width: width, height: 40)
            let screenWidth = width
            let itemCount: CGFloat = 3
            let inset = (spacing * (itemCount - 1))
            let totalMargins: CGFloat = ((itemCount - 1) * spacing) + (spacing * 2)
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
        
        selectRow(row: indexPath.row)
    }
    
    private func selectRow(row: Int) {
        if viewModel.services.count > row {
            didSelectMenu(indexPath: indexPath)
            tabView.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
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
        view.addSubview(tabView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: tabView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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

extension ServicesMocksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
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
       // cell.radioButton.isChecked = isSelected
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.selectRow(row: strongSelf.indexPath.row)
        }
    }
}
