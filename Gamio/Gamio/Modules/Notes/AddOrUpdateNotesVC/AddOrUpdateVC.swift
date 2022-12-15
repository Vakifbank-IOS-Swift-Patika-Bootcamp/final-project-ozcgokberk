//
//  AddOrUpdateVC.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

protocol AddOrUpdateVCProtocol: AnyObject {
    func refresh()
}

final class AddOrUpdateVC: UIViewController {
    private var viewModel: NotesViewModelProtocol = NotesListViewModel()
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNoteTxtView: UITextView!
    weak var delegate: AddOrUpdateVCProtocol?
    
    var noteArray: [Notes] = []
    var gameId: Int?
    var gameImg: String?
    var gameName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        configureNavigationBar()
    }
    private func viewSetup() {
//        gameNoteTxtView.text = CoreDataManager.shared.getNoteById(gameId: gameId ?? 0)?.gameNote
        guard let imgUrl = URL(string: gameImg ?? "") else { return }
        gameImageView.af.setImage(withURL: imgUrl)
        gameImageView.layer.masksToBounds = true
        gameImageView.contentMode = .scaleAspectFit
        gameNoteTxtView.layer.borderColor = UIColor.white.cgColor;
        gameNoteTxtView.layer.borderWidth = 1.0;
        gameNoteTxtView.layer.cornerRadius = 5.0;
    }
    
    private func configureNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "gameNote".localized)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
    }
    
    
    @objc func doneButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if gameNoteTxtView.text.isEmpty {
            Alert.sharedInstance.showWarning()
        } else {
            if let guideVC = storyboard.instantiateViewController(identifier: "NotesViewController") as? NotesViewController {
                guideVC.id = gameId
            }
            noteArray.append(CoreDataManager.shared.saveGameNote(id: UUID().uuidString, gameId: gameId!, gameNote: gameNoteTxtView.text, gameImage: gameImg ?? "", gameName: gameName ?? "")!)
                Alert.sharedInstance.showSuccess()
            delegate?.refresh()
            dismiss(animated: true)
        }
    }
}

extension AddOrUpdateVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
