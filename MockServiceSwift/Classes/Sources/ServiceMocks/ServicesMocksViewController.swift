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
    
    private let viewModel: ServicesMocksViewModel
    
    private let cell = ServiceMockCell.self
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 8
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.scrollDirection = .vertical
            let screenWidth = UIScreen.main.bounds.width
            let itemCount: CGFloat = 3
            let totalMargins: CGFloat = ((itemCount - 1) * spacing) + (spacing * 2)
            let screenWidthWithoutSpaces = screenWidth - totalMargins
            let itemWidth: CGFloat = screenWidthWithoutSpaces / itemCount
            let itemSize = CGSize(width: itemWidth, height: itemWidth)
            layout.itemSize = itemSize
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell, forCellWithReuseIdentifier: String(describing: cell))
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
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    deinit {
        print("\(self) deinitialized")
    }
}

extension ServicesMocksViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ServiceMockCell.self), for: indexPath) as! ServiceMockCell
        cell.set(with: item)
        return cell
    }
}

extension ServicesMocksViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        let viewController = makeMockAPIsViewController(target: item)
        self.navigationController?
            .pushViewController(viewController, animated: true)
    }
    
    func makeMockAPIsViewController(target: ServiceMockApis) -> TargetMocksViewController {
        let viewModel = TargetMocksViewModel(target: target)
        return TargetMocksViewController(viewModel: viewModel)
    }
}
