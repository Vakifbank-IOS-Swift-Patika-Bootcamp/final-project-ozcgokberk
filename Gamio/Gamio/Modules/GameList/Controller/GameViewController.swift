//
//  GameViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import UIKit

class GameViewController: UIViewController {
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGames()
    }


}

extension GameViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        print("Games Loaded")
    }
}
