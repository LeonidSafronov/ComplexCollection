//
//  ViewController.swift
//  ComplexCollection
//
//  Created by Leonid Safronov on 11.04.2022.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    enum Section: Int, CaseIterable {
        case banner = 0
        case category = 1
        
        
        var numberOfItems: Int {
            switch self {
            case .banner:
                return 1
            case .category:
                return 10
            }
        }
        
        func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
            switch self {
            case .banner:
                return collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath)
            case .category:
                return collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath)
            }
        }
        
        var indentifier: String {
            switch self {
            case .banner:
                return BannersCell.identifier
            case .category:
                return CategoryCell.identifier
            }
        }
        
        func header(collectionView: UICollectionView, indexPath: IndexPath, kind: String) -> UICollectionReusableView {
            switch self {
            case .banner:
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeader.identifier, for: indexPath)
            case .category:
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmptyHeader.identifier, for: indexPath)
            }
        }
        
        var headerSize: CGSize {
            switch self {
            
            case .banner:
                return CGSize.zero
            case .category:
                return CGSize(width: 150, height: 15)
            }
        }
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white

        collectionView?.register(BannersCell.self, forCellWithReuseIdentifier: BannersCell.identifier)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(CategoryHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeader.identifier)
        collectionView.register(EmptyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmptyHeader.identifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Section(rawValue: section)?.numberOfItems ?? .zero
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        Section(rawValue: indexPath.section)?.cell(for: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch Section(rawValue: indexPath.section) {
        case .banner:
            return CGSize(width: collectionView.frame.width, height: 150)
        case .category:
            let width = collectionView.frame.width / 2 - 20
            return CGSize(width: width, height: width)
        case .none:
            fatalError()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        Section(rawValue: indexPath.section)?.header(collectionView: collectionView, indexPath: indexPath, kind: kind) ?? UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        Section(rawValue: section)?.headerSize ?? CGSize()
    }
}





class BannersCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    let bannersCollection: UICollectionView = {
        let bannersLayout = UICollectionViewFlowLayout()
        bannersLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: bannersLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath)
            return cell
    }
    
    private func configureView() {
        
        addSubview(bannersCollection)
        backgroundColor = .cyan
        
        bannersCollection.delegate = self
        bannersCollection.dataSource = self
        bannersCollection.register(Banner.self, forCellWithReuseIdentifier: "banner")
        
        NSLayoutConstraint.activate([
            bannersCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bannersCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bannersCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bannersCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

class Banner: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoryCell: UICollectionViewCell {
    static let identifier = "category"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoryHeader: UICollectionReusableView {
    static let identifier = "categoryHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class EmptyHeader: UICollectionReusableView {
    static let identifier = "emptyHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
