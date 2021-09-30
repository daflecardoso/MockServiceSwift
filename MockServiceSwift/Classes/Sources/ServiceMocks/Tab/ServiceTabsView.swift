//
//  ServiceTabsView.swift
//  MockServiceSwift
//
//  Created by Dafle on 30/09/21.
//

import Foundation
import UIKit

class ServiceTabsView: UIView {
    
    private let cell = ServiceMockCell.self
    
    private let collectionViewHeight: CGFloat = 30
    
    lazy var collectionView: UICollectionView = {
        let spacing: CGFloat = 8
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.scrollDirection = .horizontal
            layout.sectionInset.left = spacing
            layout.sectionInset.right = spacing
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell, forCellWithReuseIdentifier: String(describing: cell))
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var didSelectMenu: ((IndexPath) -> Void)?
    let services: [ServiceMockApis]
    
    init(services: [ServiceMockApis]) {
        self.services = services
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        ])
    }
}

extension ServiceTabsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = services[indexPath.row]
        var size = item.title.size(withAttributes: nil)
        size.height = collectionViewHeight
        let imageWidth: CGFloat = item.icon == nil ? 0 : 20
        let spacer: CGFloat = 50 + imageWidth
        size.width = spacer + size.width
       // print("size", size)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = services[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell.className, for: indexPath) as! ServiceMockCell
        cell.set(with: item, index: indexPath.row + 1)
          return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectMenu?(indexPath)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.reloadData()
    }
}


