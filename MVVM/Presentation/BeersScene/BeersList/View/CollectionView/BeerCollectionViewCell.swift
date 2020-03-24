//
//  BeerCollectionViewCell.swift
//  MVVM
//
//  Created by Oscar Cardona on 16/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

class BeerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var abvLbl: UILabel!
    @IBOutlet weak var ibuLbl: UILabel!
    @IBOutlet weak var ebcLbl: UILabel!

    var downloadTask: Cancellable?

    public var data: BeerModel? {
        didSet {
            if beerName != nil {
                beerName.text = data?.name
            }
            if tagline != nil {
                tagline.text = data?.tagline
            }
            if abvLbl != nil {
                abvLbl.text = data?.abv
            }
            if ebcLbl != nil {
                ebcLbl.text = data?.ebc
            }
            if ibuLbl != nil {
                ibuLbl.text = data?.ibu
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        beerName.text = ""
        beerImage.image = UIImage(named: Constants.defaultImage)
        tagline.text = ""
    }

    func setupShadow() {
        contentView.layer.cornerRadius = 6.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.clear.cgColor
    }
}
