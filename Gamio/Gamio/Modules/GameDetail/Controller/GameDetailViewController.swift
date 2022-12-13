//
//  GameDetailViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import UIKit


final class GameDetailViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var imgAdditional: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var metacritic: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var ratingValue: UILabel!
    @IBOutlet weak var releaseValue: UILabel!
    @IBOutlet weak var genreValue: UILabel!
    @IBOutlet weak var metacriticValue: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    //Mark: Properties
    private var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()
    var gameId: Int?
    private var imageUrl: String? {
        return viewModel.getGameImageUrl()
    }
    private var gameName: String? {
        return viewModel.getGameName()
    }
    
    var favoritedGames: [Favorites] = []
    override func viewDidLoad() {
        viewSetup()
        super.viewDidLoad()
        guard let id = gameId else { return }
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
        
    }
    
    private func viewSetup() {
        releaseDate.text = "releasedText".localized
        rating.text = "rateText".localized
        metacritic.text = "metacriticText".localized
        addNoteButton.setTitle("addNoteText".localized, for: .normal)
        favoriteButton.setTitle("likeItText".localized, for: .normal)
        genres.text = "genresText".localized
        overview.text = "overviewText".localized
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let guideVC = storyboard.instantiateViewController(identifier: "AddOrUpdateVC") as? AddOrUpdateVC {
            guideVC.gameId = gameId
            guideVC.gameImg = imageUrl
            guideVC.gameName = gameName
            present(guideVC, animated: true)
        }
    }
    
    @IBAction func addFavoritesButtonPressed(_ sender: UIButton) {
        if !CoreDataManager.shared.ifFavoritesExist(gameId: Int32(gameId!)) {
            CoreDataManager.shared.saveFavorites(id: UUID().uuidString, gameId: Int32(gameId!), gameImg: imageUrl ?? "")
            favoriteButton.setImage(UIImage(named: "hearth.filled"), for: .normal)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let guideVC = storyboard.instantiateViewController(identifier: "FavoritesViewController") as? FavoritesViewController {
                guideVC.favorites = favoritedGames
                present(guideVC, animated: true)
            }
        } else {
            favoriteButton.setImage(UIImage(named: "hearth"), for: .normal)
        }
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameDetailLoaded() {
        guard let imgUrl = URL(string: imageUrl ?? "") else { return }
        img.af.setImage(withURL: imgUrl)
        guard let imgAdditionalUrl = viewModel.getAdditionalImageUrl() else { return }
        imgAdditional.af.setImage(withURL: imgAdditionalUrl)
        gameNameLabel.text = gameName
        releaseValue.text = "📆 \(viewModel.getReleasedDate())"
        genreValue.text = viewModel.getGenres().first?.name
        ratingValue.text = "⭐️ \(viewModel.getRating())/5"
        metacriticValue.text = "\(viewModel.getMetacritic())/100"
        descriptionLabel.text = Constants.removeHTMLTags(in: "\(viewModel.getDescription())")
    }
}
