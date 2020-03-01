//
//  HomeViewController.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

class HomeViewController: UIViewController, Storyboarded {

    // MARK: - Properties
    private var model: HomeModel?
    var viewModel: HomeViewModel?
    weak var coordinator: HomeCoordinator?

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        viewModel?.viewDidLoad()
    }
}

private extension HomeViewController {

    // MARK: - Binding
    private func setupBinding() {
        viewModel?.model.bind(listener: { [unowned self]  homeModel in

            DispatchQueue.main.async {
                self.model = homeModel
                guard let items = homeModel?.items else {
                    return
                }
                homeModel?.items.map { print($0)}
                _ = items.map { print($0.title ?? "")}
            }
        })

        viewModel?.loadingStatus.bind(listener: { (status) in
            guard let status = status else {
                return
            }
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
        return String(describing: self.self)
    }
}
