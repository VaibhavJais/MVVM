//
//  BeersListViewController.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

class BeersListViewController: UIViewController, Storyboarded {
    // MARK: Private Constants
    private struct Constants {
        static let cellIdentifier = "BeersCollectionViewCellID"
        static let cellName = "BeerCollectionViewCell"
        static let fontName = "Verdana-bold"
    }
    
    private var model: BeersListModel?
    var viewModel: BeersListViewModel?
    weak var coordinator: BeersCoordinator?
    private let collectionView: UICollectionView = {
        let layout = BeersListCollectionViewLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
    }()
    private let titleLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont(name: Constants.fontName, size: 30)
        lbl.backgroundColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.adjustsFontSizeToFitWidth = true
        
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    func setupBinding() {
        viewModel?.items.bind(listener: { [weak self]  items in
            guard let items = items else { return }
            self?.titleLbl.text = "Beers List"
            self?.model = items
            self?.collectionView.reloadData()
        })
    }
}

// MARK: - Setup View
extension BeersListViewController {
    private func setupView() {
        view.addSubview(titleLbl)
        setupTitleConstraints()
        collectionView.register(UINib(nibName: Constants.cellName,
                                      bundle: nil ),
                                forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupCollectionConstraints()
    }
    
}

// MARK: - UICollectionViewDataSource
extension BeersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.model?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? BeerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = model?.items?[indexPath.row]
        let backgroundQueue = DispatchQueue(label: "backgroundQueue",
                                            qos: .background,
                                            attributes: .concurrent,
                                            autoreleaseFrequency: .inherit,
                                            target: nil)


        backgroundQueue.async { [weak self] in

            cell.data?.image.bind(listener: { (data) in
                guard let data = data else { return }
                cell.beerImage.image = UIImage(data: data)
            })

            self?.viewModel?.image(url: cell.data?.imageUrl, index: indexPath.row)

//            if let imageUrl = cell.data?.imageUrl,
//                let url = URL(string: imageUrl) {
//                if let imageData = try? Data(contentsOf: url) {
//                    DispatchQueue.main.async() {
//                        cell.beerImage.image = UIImage(data: imageData)
//                    }
//                }
//            }
        }

        return cell
    }
    
}

// MARK: - UICollectionViewDataSource
extension BeersListViewController: UICollectionViewDelegate {
    
}


// MARK: - Constraints
private extension BeersListViewController {
    private func setupCollectionConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupTitleConstraints() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}