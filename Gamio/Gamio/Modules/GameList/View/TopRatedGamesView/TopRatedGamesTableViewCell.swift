//
//  TopRatedGamesTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import UIKit
protocol TopRatedGamesTableViewCellDelegate: AnyObject {
    func testTableViewCellDidTapped(_ cell: TopRatedGamesTableViewCell, game: GameListModel)
    func sortButtonPressed()
}
class TopRatedGamesTableViewCell: UITableViewCell {
    
    class var defaultHeight: Double { return 250 }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var topRatedGames: [GameListModel] = []
    weak var delegate: TopRatedGamesTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "TopRatedGamesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedGamesCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: TopRatedGamesCollectionViewCell.defaultWidth, height: TopRatedGamesCollectionViewCell.defaultHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    @IBAction func sortButtonPressed(_ sender: Any) {
        delegate?.sortButtonPressed()
    }
}

extension TopRatedGamesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedGamesCollectionViewCell", for: indexPath) as! TopRatedGamesCollectionViewCell
        cell.configureCell(model: topRatedGames[indexPath.row])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRatedGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.testTableViewCellDidTapped(self, game: topRatedGames[indexPath.row])
    }
}
