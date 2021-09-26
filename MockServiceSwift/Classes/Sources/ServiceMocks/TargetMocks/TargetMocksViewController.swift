//
//  MockAPIsViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 30/08/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class TargetMocksViewController: UIViewController {
    
    private let viewModel: TargetMocksViewModel

    private let cell = TargetMocksCell.self
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 8
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.scrollDirection = .vertical
            let screenWidth = UIScreen.main.bounds.width
            let itemCount: CGFloat = 2
            let totalMargins: CGFloat = ((itemCount - 1) * spacing) + (spacing * 2)
            let screenWidthWithoutSpaces = screenWidth - totalMargins
            let itemWidth: CGFloat = screenWidthWithoutSpaces / itemCount
            let itemSize = CGSize(width: itemWidth, height: 140)
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
    
    init(viewModel: TargetMocksViewModel) {
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
        setupTableView()
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundContainerViews
        navigationItem.titleView = UILabel.title(viewModel.target.title)
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

extension TargetMocksViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TargetMocksCell.self), for: indexPath) as! TargetMocksCell
        cell.set(with: item)
        cell.switchChanged = { [unowned self] in
            self.viewModel.toggle(item: item, isOn: cell.switchMock.isOn)
            self.collectionView.reloadData()
        }
        return cell
    }
}

extension TargetMocksViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
    
        let viewController = makeEndPointMocksViewController(endpoint: item)
        self.navigationController?
            .pushViewController(viewController, animated: true)
    }
    
    func makeEndPointMocksViewController(endpoint: MockAPI) -> EndPointMocksViewController {
        let viewModel = EndPointMocksViewModel(endpoint: endpoint)
        return EndPointMocksViewController(viewModel: viewModel)
    }
}
