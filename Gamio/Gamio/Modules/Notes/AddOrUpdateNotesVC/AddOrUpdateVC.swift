//
//  AddOrUpdateVC.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

final class AddOrUpdateVC: UIViewController {
    private var viewModel: NotesViewModelProtocol = NotesListViewModel()
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNoteTxtView: UITextView!

    var gameId: Int?
    var gameImg: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "SomeTitle")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func doneButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let guideVC = storyboard.instantiateViewController(identifier: "NotesViewController") as? NotesViewController {
            guideVC.id = gameId
        }
        CoreDataManager.shared.saveGameNote(id: UUID().uuidString, gameId: gameId!, gameNote: gameNoteTxtView.text, gameImage: gameImg ?? "")
//        CoreDataManager.shared.deleteAllNotes()
        dismiss(animated: true)
    }

}
