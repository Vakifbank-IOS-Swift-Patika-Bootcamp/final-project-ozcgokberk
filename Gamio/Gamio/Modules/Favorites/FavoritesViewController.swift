//
//  FavoritesViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    var favorites: [Favorites]? = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        
//    }
    @objc func passFavorites() {
        favoritesTableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell, let model = favorites?[indexPath.row] else { return UITableViewCell() }
//        cell.configure(model: model)
        return cell
    }
    
    
}
