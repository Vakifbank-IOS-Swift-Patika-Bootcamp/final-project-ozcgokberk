//
//  TopRatedGamesCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 8.12.2022.
//

import UIKit
import AlamofireImage

class TopRatedGamesCell: UITableViewCell {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameRatePoint: UILabel!
    @IBOutlet weak var gameRateCount: UILabel!
    @IBOutlet weak var gameReleasedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: GameListModel) {
        gameName.text = model.name
        guard let url = URL(string:  model.img) else { return }
        gameImage.af.setImage(withURL: url)
        gameImage.contentMode = .scaleAspectFill
        gameRatePoint.text = "\(model.rating) / 5"
        gameRateCount.text = "Rating Count: \(model.ratingCount)"
        gameReleasedDate.text = Constants.formatDate(from: model.released)
        
    }
    
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
}
