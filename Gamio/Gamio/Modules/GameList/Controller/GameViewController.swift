//
//  GameViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import UIKit
import L10n_swift
final class GameViewController: UIViewController {
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    
    @IBOutlet weak var topRatedGamesTableView: UITableView!
    private lazy var picker = UIPickerView()
    private lazy var toolBar = UIToolbar()
    private lazy var sortOptions : [SiralamaMenu] = [.SortByName, .SortByReleased, .SortByRatinCount, .SortyByPlaytime]
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "searchBarPlaceholder".localized
        }
    }
    
    //Mark: Properties
    private var searchedGames =  [GameListModel]()
    private var allGames: [GameListModel] = []
    private var sortedByReleased: [GameListModel] = []
    private var topRatedGames: [GameListModel] = []
    private var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLanguage()
        viewModel.delegate = self
        viewModel.fetchGames()
        viewModel.getLatestGames()
        viewModel.getMostRatedGames()
        setupTopRatedTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .RefreshTableView, object: nil)
        
    }
    
    private func setupTopRatedTableView() {
        topRatedGamesTableView.dataSource = self
        topRatedGamesTableView.delegate = self
        topRatedGamesTableView.register(UINib(nibName: "NewReleasesTableViewCell", bundle: nil), forCellReuseIdentifier: "NewReleasesTableViewCell")
        topRatedGamesTableView.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "GamesTableViewCell")
        topRatedGamesTableView.register(UINib(nibName: "TopRatedGamesTableViewCell", bundle: nil), forCellReuseIdentifier: "TopRatedGamesTableViewCell")
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
    
    @objc func reloadTableView() {
        checkLanguage()
        topRatedGamesTableView.reloadSections(IndexSet(0...2), with: .none)
        topRatedGamesTableView.reloadData()
        
    }
    
    private func checkLanguage() {
        switch L10n.shared.language {
        case "en":
            languageButton.setImage(UIImage(named: "english"), for: .normal)
        case "tr":
            languageButton.setImage(UIImage(named: "turkiye"), for: .normal)
        default:
            break
        }
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
            allGames.sort() { $0.name > $1.name }
        case 1:
            allGames.sort() { $0.ratingCount > $1.ratingCount }
        case 2:
            allGames.sort() { $0.released > $1.released }
        case 3:
            allGames.sort() { $0.playTime > $1.playTime }
        default:
            break
        }
//        let indexpath = IndexSet(integer: 1)
//        topRatedGamesTableView.reloadSections(indexpath, with: .none)
        topRatedGamesTableView.reloadData()
//        NotificationCenter.default.post(name: .RefreshGamesTableView, object: nil)
    }
    
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sortedByReleased.count > 0, allGames.count > 0, topRatedGames.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch HomeSectionType.init(rawValue: indexPath.section) {
        case .newGames:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewReleasesTableViewCell", for: indexPath) as! NewReleasesTableViewCell
            cell.mostRecentGames = sortedByReleased
            cell.delegate = self
            return cell
            
        case .allGames:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GamesTableViewCell", for: indexPath) as! GamesTableViewCell
            cell.allGames = allGames
            cell.delegate = self
            return cell
        case .topRatedGames:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedGamesTableViewCell", for: indexPath) as! TopRatedGamesTableViewCell
            cell.topRatedGames = topRatedGames
            cell.delegate = self
            return cell
        default: return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch HomeSectionType.init(rawValue: indexPath.section) {
        case .newGames: return NewReleasesTableViewCell.defaultHeight
        case .allGames: return GamesTableViewCell.defaultHeight
        case .topRatedGames: return TopRatedGamesTableViewCell.defaultHeight
        default: return 0
            
        }
    }
}

extension GameViewController: GameListViewModelDelegate {

    func latesGamesLoaded(latestGames: [GameListModel]?) {
        self.sortedByReleased = latestGames ?? []
        topRatedGamesTableView.reloadData()
    }
    
    func gamesLoaded(gamesArray: [GameListModel]?) {
        self.allGames = gamesArray ?? []
        topRatedGamesTableView.reloadData()
    }
    
    func topRatedGamesLoaded(topRatedGames: [GameListModel]?) {
        self.topRatedGames = topRatedGames ?? []
        topRatedGamesTableView.reloadData()
    }
}

extension GameViewController: NewReleasesTableViewCellDelegate {
    func sortButtonPressed() {
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
    
    func newReleasesTableViewCellDidTapped(_ cell: NewReleasesTableViewCell, game: GameListModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let guideVC = storyboard.instantiateViewController(identifier: "GameDetailViewController") as? GameDetailViewController {
            guideVC.gameId = game.id
            navigationController?.pushViewController(guideVC, animated: true)
        }
    }
}

extension GameViewController: GamesTableViewCellDelegate {
    
    func seeAllButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let guideVC = storyboard.instantiateViewController(identifier: "SeeAllGamesVC") as? SeeAllGamesVC {
            guideVC.allGames = allGames
            navigationController?.pushViewController(guideVC, animated: true)
        }
    }
    
    
    func gamesTableViewCellDidTapped(_ cell: GamesTableViewCell, game: GameListModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let guideVC = storyboard.instantiateViewController(identifier: "GameDetailViewController") as? GameDetailViewController {
            guideVC.gameId = game.id
            navigationController?.pushViewController(guideVC, animated: true)
        }
    }
}

extension GameViewController: TopRatedGamesTableViewCellDelegate {
    func ratedGamesTableViewCellDidTapped(_ cell: TopRatedGamesTableViewCell, game: GameListModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let guideVC = storyboard.instantiateViewController(identifier: "GameDetailViewController") as? GameDetailViewController {
            guideVC.gameId = game.id
            navigationController?.pushViewController(guideVC, animated: true)
        }
    }
}

