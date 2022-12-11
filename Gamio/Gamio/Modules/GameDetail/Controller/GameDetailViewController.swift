//
//  GameDetailViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet weak var imgAdditional: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var metacritic: UILabel!
    private var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()
    var gameId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = gameId else { return }
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
        
    }
}
extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameDetailLoaded() {
        guard let imgUrl = viewModel.getGameImageUrl() else { return }
        img.af.setImage(withURL: imgUrl)
        guard let imgAdditionalUrl = viewModel.getAdditionalImageUrl() else { return }
        imgAdditional.af.setImage(withURL: imgAdditionalUrl)
        gameName.text = viewModel.getGameName()
        releaseDate.text = "📆 \(viewModel.getReleasedDate())"
        genres.text = viewModel.getGenres().first?.name
        rating.text = "⭐️ \(viewModel.getRating())/5"
        metacritic.text = "\(viewModel.getMetacritic())/100"
        descriptionLabel.text = Constants.removeHTMLTags(in: "\(viewModel.getDescription())")
    }
}
