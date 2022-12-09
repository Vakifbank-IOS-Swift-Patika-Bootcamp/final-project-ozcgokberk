//
//  GameViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import UIKit

class GameViewController: UIViewController {
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    
    @IBOutlet weak var mostRecentGamesCollectionView: UICollectionView!
    @IBOutlet weak var topRatedGamesTableView: UITableView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    var timer = Timer()
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGames()
        setUpCollectionView()
        setupPageView()
        setupTopRatedTableView()
    }
    
    
    private func setUpCollectionView() {
        let nibCell = UINib(nibName: "MostRecentCollectionViewCell", bundle: nil)
        mostRecentGamesCollectionView.register(nibCell, forCellWithReuseIdentifier: "MostRecentCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 360 , height: 180)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        mostRecentGamesCollectionView.collectionViewLayout = flowLayout
        mostRecentGamesCollectionView.layer.cornerRadius = 10
        mostRecentGamesCollectionView.delegate = self
        mostRecentGamesCollectionView.dataSource = self
    }
    
    private func setupPageView() {
        pageView.numberOfPages = 5
        pageView.currentPage = 0
    }
    
    private func setupTopRatedTableView() {
        topRatedGamesTableView.dataSource = self
        topRatedGamesTableView.delegate = self
        topRatedGamesTableView.register(UINib(nibName: "TopRatedGamesCell", bundle: nil), forCellReuseIdentifier: "TopRatedCell")
        
    }
    
}
extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedCell", for: indexPath) as! TopRatedGamesCell
        let model = viewModel.getGame(at: indexPath.row)
        cell.configureCell(model: model!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostRecentCollectionViewCell", for: indexPath) as! MostRecentCollectionViewCell
        let model = viewModel.getGame(at: indexPath.row)
        cell.configureCell(model: model!)
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        let inset: CGFloat =
    //        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    //    }
}
extension GameViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        mostRecentGamesCollectionView.reloadData()
        topRatedGamesTableView.reloadData()
    }
}
