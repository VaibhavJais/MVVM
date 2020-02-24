//
//  ForcesListTableViewCell.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 16/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit

// MARK: - ForcesListTableViewCell
class ForcesListTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    var data: ForcesListModel? {
        didSet {
            guard let data = data else {
                return
            }
            self.subtitle.text = data.forcesName
            self.title.text = data.forcesId
        }
    }
}
