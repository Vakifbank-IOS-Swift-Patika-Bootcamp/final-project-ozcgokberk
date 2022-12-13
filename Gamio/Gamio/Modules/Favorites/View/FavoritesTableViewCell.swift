//
//  FavoritesTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with model: FavoriteModel) {
        gameImage.layer.cornerRadius = 8
        gameImage.clipsToBounds = true
        name.text = model.name
        rating.text = "\(model.rating!) / 5"
        released.text = model.released
        guard let url = URL(string:  model.backgroundImage!) else { return }
        gameImage.af.setImage(withURL: url)

    }

   
    
}
