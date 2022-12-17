//
//  NotesViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit
import CoreData

final class NotesViewController: UIViewController {
    private var viewModel: NotesViewModelProtocol = NotesListViewModel()
    @IBOutlet weak var notesTableView: UITableView!
    private var notes: [Notes] = []
    var id: Int?
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchNotes()
    }
    
    private func configureTableView() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        notesTableView.separatorColor = .white
    }
    
    private func editSelectedNote(index: Int) {
        selectedIndexPath = IndexPath(row: index, section: 0)
        let note = notes[index]
        if let guideVC = Constants.storyboard.instantiateViewController(identifier: "AddOrUpdateVC") as? AddOrUpdateVC {
            guideVC.selectedNote = note
            guideVC.delegate = self
            present(guideVC, animated: true)
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell") as? NotesTableViewCell else { return UITableViewCell() }
        cell.configureCell(model: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
        
    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            CoreDataManager.shared.managedContext.delete(notes[indexPath.row])
    //            notes.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //            do {
    //                try CoreDataManager.shared.managedContext.save()
    //                Alert.sharedInstance.showSuccess()
    //                tableView.reloadData()
    //            } catch let error as NSError {
    //                print("Could not save. \(error), \(error.userInfo)")
    //                Alert.sharedInstance.showWarning()
    //            }
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editButton = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            self.editSelectedNote(index: indexPath.row)
        }
        let deleteButton = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            CoreDataManager.shared.managedContext.delete(self.notes[indexPath.row])
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try CoreDataManager.shared.managedContext.save()
                Alert.sharedInstance.showSuccess()
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                Alert.sharedInstance.showWarning()
            }
        }
        editButton.backgroundColor = .systemGray5
        let swipeActions = UISwipeActionsConfiguration(actions: [editButton,deleteButton])
        return swipeActions
    }
}

extension NotesViewController: NotesViewModelDelegate {
    func notesLoaded(notes: [Notes]) {
        self.notes = notes
        notesTableView.reloadData()
        
    }
}
extension NotesViewController: AddOrUpdateVCProtocol {
    func refresh() {
        notes = CoreDataManager.shared.getNotes()
        notesTableView.reloadData()
    }
}

