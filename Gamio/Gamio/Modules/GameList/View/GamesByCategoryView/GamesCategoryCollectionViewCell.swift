//
//  GamesCategoryCollectionViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 16.12.2022.
//

import UIKit

class GamesCategoryCollectionViewCell: UICollectionViewCell {
    class var defaultHeight: CGFloat { return 50 }
    class var defaultWidth: CGFloat { return 120 }
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    
    func setCell() {
        layer.cornerRadius = 20
    }
}
