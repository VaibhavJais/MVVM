//
//  MainListViewController.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

class MainListViewController: UIViewController, Storyboarded {

    // MARK: - Properties
    private var items: [MainListModel]?
    var viewModel: MainListViewModel?
    //weak var coordinator: MainListCoordinator?

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        viewModel?.viewDidLoad()
    }
}

private extension MainListViewController {

    // MARK: - Binding
    private func setupBinding() {
        viewModel?.items.bind(listener: { [unowned self]  (items) in
            DispatchQueue.main.async {
                self.items = items
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

    }

    private func className() -> String {
        return String(describing: ForcesListViewModel.self)
    }
}
