//
//  AllGamesTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 15.12.2022.
//

import UIKit

class AllGamesTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(model: GameListModel) {
        gameImage.layer.cornerRadius = 10
        gameImage.clipsToBounds = true
        gameName.text = model.name
        guard let url = URL(string:  model.img ) else { return }
        gameImage.af.setImage(withURL: url)
    }
    
}