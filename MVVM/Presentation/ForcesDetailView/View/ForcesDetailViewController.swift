//
//  ForcesDetailViewController.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 17/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

//MARK: - ForcesDetailViewController
class ForcesDetailViewController: UIViewController, Storyboarded {

    // MARK: - Properties
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var urlLbl: UIButton!
    weak var coordinator: ForcesCoordinator?
    var viewModel: ForcesDetailViewModel?

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        viewModel?.viewDidLoad()
    }

    // MARK: - Binding
    private func setupBinding() {
        viewModel?.items.bind(listener: { [unowned self] (forcesDetail) in
            self.titleLbl.text = forcesDetail?.name
            self.descLbl.text = forcesDetail?.description
            self.urlLbl.titleLabel?.text = forcesDetail?.url
        })

        viewModel?.loadingStatus.bind(listener: { [unowned self] status in
            switch status {
            case .start:
                print("[\(self.className())] Loading: Start")
            case .stop:
                print("[\(self.className())] Loading: Stop")
            }
        })

        viewModel?.error.bind(listener: { (error) in
            guard let error = error else { return }
            print("[Error] ViewController: \(error.localizedDescription)")
        })
    }

    private func className() -> String {
        return String(describing: ForcesDetailViewModel.self)
    }
}
