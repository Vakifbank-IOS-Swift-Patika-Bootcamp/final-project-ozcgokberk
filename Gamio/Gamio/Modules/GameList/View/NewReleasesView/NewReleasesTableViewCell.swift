//
//  NewReleasesTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 8.12.2022.
//

import Foundation
import UIKit
protocol NewReleasesTableViewCellDelegate: AnyObject {
    func testTableViewCellDidTapped(_ cell: NewReleasesTableViewCell, game: GameListModel)
}
class NewReleasesTableViewCell: UITableViewCell {
    
    class var defaultHeight: Double { return 200 }
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mostRecentGames: [GameListModel] = []
    weak var delegate: NewReleasesTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "MostRecentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MostRecentCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: MostRecentCollectionViewCell.defaultWidth, height: MostRecentCollectionViewCell.defaultHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension NewReleasesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostRecentCollectionViewCell", for: indexPath) as! MostRecentCollectionViewCell
        cell.configureCell(model: mostRecentGames[indexPath.row])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mostRecentGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.testTableViewCellDidTapped(self, game: mostRecentGames[indexPath.row])
    }
}
