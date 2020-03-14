//
//  HomeCollectionViewCell.swift
//  MVVM
//
//  Created by Oscar Cardona on 01/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    public var data: HomeItemModel? {
        didSet {
            if title != nil {
                title.text = data?.title
            }

            if subtitle != nil {
                subtitle.text = data?.description
            }

            if imageView != nil {
                guard let imageName = data?.imageName,
                    let image = UIImage(named: imageName) else {
                    return
                }
                imageView.image = image
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        imageView.image = nil
        subtitle.text = ""
    }
}
