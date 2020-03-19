//
//  BeersListCollectionViewLayout.swift
//  MVVM
//
//  Created by Oscar Cardona on 16/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit

final class BeersListCollectionViewLayout: UICollectionViewFlowLayout {

    // MARK: - Constants
    private struct Constants {
        static let defaultCellWidth: CGFloat = 360
        static let defaultCellHeight: CGFloat = 128
        static let leftMargin: CGFloat = 20
        static let rightMargin: CGFloat = 20
        static let topMargin: CGFloat = 4
        static let bottomMargin: CGFloat = 20
        static let margins: CGFloat = 30
    }

    private var defaultCellSize: CGSize {
        let defaultSize = CGSize(width: Constants.defaultCellWidth, height: Constants.defaultCellHeight)
        guard let collectionView = collectionView else { return defaultSize}
        guard var cellWidth = collectionView.superview?.frame.size.width else { return defaultSize }
        cellWidth -= Constants.margins

        return CGSize(width: cellWidth, height: defaultSize.height)
    }

    // MARK: - lifeCycle
    override func prepare() {
        super.prepare()
        self.itemSize = defaultCellSize
        self.sectionInset = UIEdgeInsets(top: Constants.topMargin,
                                         left: Constants.leftMargin,
                                         bottom: Constants.bottomMargin,
                                         right:  Constants.rightMargin)
    }

}
