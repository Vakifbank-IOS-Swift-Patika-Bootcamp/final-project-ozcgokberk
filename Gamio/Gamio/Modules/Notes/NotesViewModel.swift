//
//  NotesViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import Foundation
import CoreData
protocol NotesViewModelProtocol {
    var delegate: NotesViewModelDelegate? { get set }
    func fetchNotes()
    func fetchNoteDetail(id: Int)
    func getNotesCount() -> Int
    
}
protocol NotesViewModelDelegate: AnyObject {
    func notesLoaded(notes: [Notes])
}

final class NotesListViewModel:  NotesViewModelProtocol {
    private var notesModel: NotesModel?
    weak var delegate: NotesViewModelDelegate?
    private var notes: [Notes]?
    private var game: GameDetailModel?
    
    func fetchNotes() {
        notes = CoreDataManager.shared.getNotes()
        delegate?.notesLoaded(notes: notes ?? [])
    }

    func fetchNoteDetail(id: Int) {
        GameDBClient.getNoteDetail(gameId: id) { [weak self] notesDetail, error in
            guard let self = self else { return }
            self.notesModel = notesDetail
        }
    }
    
    func getNotesCount() -> Int {
        notes?.count ?? 0
    }

}
