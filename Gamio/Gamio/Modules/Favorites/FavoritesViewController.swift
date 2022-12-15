//
//  FavoritesViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    var gameId: Int?
    var gameImg: String?
    var gameName: String?
    var gameRate: Double?
    
    var favorites: [Favorites] = []
    private var viewModel: FavoritesViewModelProtocol = FavoritesViewModel()
    @IBOutlet weak var favoritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchFavorites()
    }
    
    private func configureTableView() {
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
        favoritesTableView.separatorColor = .white
        
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as? FavoritesTableViewCell else { return UITableViewCell() }
        cell.configureCell(model: favorites[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.managedContext.delete(favorites[indexPath.row])
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try CoreDataManager.shared.managedContext.save()
                Alert.sharedInstance.showSuccess()
                tableView.reloadData()
            } catch let error as NSError {
                Alert.sharedInstance.showError()
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
extension FavoritesViewController: FavoritesViewModelDelegate {
    func favoritesLoaded(favorites: [Favorites]) {
        self.favorites = favorites
        favoritesTableView.reloadData()
    }
}
extension FavoritesViewController: GameDetailVCProtocol {
    func refresh() {
        favorites = CoreDataManager.shared.getFavorites()
        favoritesTableView.reloadData()
    }
}
