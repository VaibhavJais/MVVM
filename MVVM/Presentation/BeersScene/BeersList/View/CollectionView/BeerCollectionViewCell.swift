//
//  BeerCollectionViewCell.swift
//  MVVM
//
//  Created by Oscar Cardona on 16/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var beerImage: UIImageView!

    public var data: BeerModel? {
        didSet {
            if beerName != nil {
                beerName.text = data?.name
            }

            if tagline != nil {
                tagline.text = data?.tagline
            }

            if beerImage != nil {
                //                guard let imageName = data?.imageName,
                //                    let image = UIImage(named: imageName) else {
                //                        return
                //                }
                //                imageView.image = image
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        beerName.text = ""
        beerImage.image = nil
        tagline.text = ""
    }

}
