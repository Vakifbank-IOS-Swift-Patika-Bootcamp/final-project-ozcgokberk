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
    lazy var picker = UIPickerView()
    lazy var toolBar = UIToolbar()
    lazy var sortOptions : [SiralamaMenu] = [.SortByName, .SortByReleased, .SortByRatinCount, .SortyByPlaytime]
    private var gamesArray: [GameListModel] = []
    private var sortedByReleased: [GameListModel] = []
    var selectedTextfieldIndex : Int?
    @IBOutlet weak var sortButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGames()
        viewModel.getLatestGames()
//        setUpCollectionView()
        setupTopRatedTableView()
        
    }
    
    
    private func setUpCollectionView() {
        let nibCell = UINib(nibName: "MostRecentCollectionViewCell", bundle: nil)
//        mostRecentGamesCollectionView.register(nibCell, forCellWithReuseIdentifier: "MostRecentCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 360 , height: 180)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        mostRecentGamesCollectionView.collectionViewLayout = flowLayout
        mostRecentGamesCollectionView.layer.cornerRadius = 10
    }
    
    private func setupTopRatedTableView() {
        topRatedGamesTableView.dataSource = self
        topRatedGamesTableView.delegate = self
//        topRatedGamesTableView.register(UINib(nibName: "TopRatedGamesCell", bundle: nil), forCellReuseIdentifier: "TopRatedCell")
        topRatedGamesTableView.register(UINib(nibName: "NewReleasesTableViewCell", bundle: nil), forCellReuseIdentifier: "NewReleasesTableViewCell")
    }
    
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        toolBar.items = [cancelBtn, space, doneBtn]
        self.view.addSubview(toolBar)
    }
    
    @objc func doneButtonPressed() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        topRatedGamesTableView.reloadData()
    }
    @objc func cancelButtonPressed() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        topRatedGamesTableView.reloadData()
    }
    
}
extension GameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOptions[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch sortOptions[row].rawValue {
        case 0:
            gamesArray.sort() { $0.name > $1.name }
        case 1:
            gamesArray.sort() { $0.ratingCount > $1.ratingCount }
        case 2:
            gamesArray.sort() { $0.released > $1.released }
        case 3:
            gamesArray.sort() { $0.playTime > $1.playTime }
        default:
            break
        }
        topRatedGamesTableView.reloadData()
    }
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortedByReleased.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewReleasesTableViewCell", for: indexPath) as! NewReleasesTableViewCell
        cell.mostRecentGames = sortedByReleased
        cell.delegate = self
        
        return cell
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedCell", for: indexPath) as! TopRatedGamesCell
//            let model = gamesArray[indexPath.row]
//            cell.configureCell(model: model)
//            return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewReleasesTableViewCell.defaultHeight
    }
    
}
//extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return sortedByReleased.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostRecentCollectionViewCell", for: indexPath) as! MostRecentCollectionViewCell
//        let model = sortedByReleased[indexPath.row]
//        cell.configureCell(model: model)
//        return cell
//    }
//}
extension GameViewController: GameListViewModelDelegate {
    func latesGamesLoaded(latestGames: [GameListModel]?) {
        self.sortedByReleased = latestGames ?? []
        topRatedGamesTableView.reloadData()
//        mostRecentGamesCollectionView.reloadData()
    }
    
    func gamesLoaded(gamesArray: [GameListModel]?) {
        self.gamesArray = gamesArray ?? []
        topRatedGamesTableView.reloadData()
    }
    
}
extension GameViewController: TestTableViewCellDelegate {
    func testTableViewCellDidTapped(_ cell: NewReleasesTableViewCell, game: GameListModel) {
        print(game)
    }
}
