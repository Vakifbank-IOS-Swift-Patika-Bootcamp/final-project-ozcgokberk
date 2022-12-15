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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.managedContext.delete(notes[indexPath.row])
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try CoreDataManager.shared.managedContext.save()
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
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
