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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        setupView()
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
         self.title = "Beers List"
    }

    func setupBinding() {
        viewModel?.items.bind(listener: { [weak self]  items in
            guard let items = items else { return }
            self?.model = items
            self?.collectionView.reloadData()
        })

        viewModel?.loadingStatus.bind(listener: { [weak self] (status) in
            switch status {
            case .start:
                DispatchQueue.main.async {
                    self?.showSpinnerView()
                }
            default:
                DispatchQueue.main.async {
                    self?.hideSpinnerView()
                }
            }
        })
    }
}

// MARK: - Setup View
extension BeersListViewController {
    private func setupView() {
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

        if let data = cell.data?.image.value {
            DispatchQueue.main.async() {
                cell.beerImage.image = UIImage(data: data)
            }
            return cell
        }

        let backgroundQueue = DispatchQueue(label: "bQueue",
                                            qos: .background,
                                            attributes: .concurrent,
                                            autoreleaseFrequency: .inherit,
                                            target: nil)

        backgroundQueue.async { [weak self] in
            cell.data?.image.bind(listener: { (data) in
                guard let data = data else { return }
                DispatchQueue.main.async() {
                    cell.beerImage.image = UIImage(data: data)
                }
            })
            cell.downloadTask = self?.viewModel?.image(url: cell.data?.imageUrl, index: indexPath.row)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BeersListViewController: UICollectionViewDelegate {
    // TODO: Implement user action
}


// MARK: - Constraints
private extension BeersListViewController {
    private func setupCollectionConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}


// MARK: - Spinner
extension BeersListViewController {
    // TODO: Implement Spinner
    func showSpinnerView() {

    }

    func hideSpinnerView() {

    }
}
