//
//  ViewController.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 13/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

// MARK: - Private Constants
private struct ForcesListViewControllerConstants {
    static let cellNibName = "ForcesListTableViewCell"
    static let cellIdentifier = "CellAcceptedReuseID"
    static let cellHeight = CGFloat(66)
}

// MARK: - ForceListViewController
final class ForcesListViewController: UIViewController, Storyboarded {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private var items: [ForcesListModel]?
    var viewModel: ForcesListViewModel?
    weak var coordinator: ForcesCoordinator?

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        viewModel?.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Forces LIST viewDidDisappear")
    }

    // MARK: - Binding
    private func setupBinding() {
        viewModel?.items.bind(listener: { [unowned self]  (items) in
            DispatchQueue.main.async {
                self.items = items
                self.tableView.reloadData()
            }
        })

        viewModel?.loadingStatus.bind(listener: { (status) in
            switch status {
            case .start:
                print("[\(self.className())] Loading: Start")
            case .stop:
                print("[\(self.className())] Loading: Stop")
            }
        })
    }

    private func setupView() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.backgroundColor = .white
        tableView.register(UINib(nibName: ForcesListViewControllerConstants.cellNibName,
                                 bundle: nil),
                           forCellReuseIdentifier: ForcesListViewControllerConstants.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func className() -> String {
        return String(describing: ForcesListViewModel.self)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ForcesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForcesListViewControllerConstants.cellIdentifier,
                                                       for: indexPath) as? ForcesListTableViewCell else {
                                                        return UITableViewCell()
        }
        
        guard let data = items else {
            return UITableViewCell()
        }

        cell.data = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ForcesListViewControllerConstants.cellHeight
    }
}

// MARK: - UITableViewDelegate
extension ForcesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showItemDetail(indexPath: indexPath, coordinator: coordinator)
    }
}

