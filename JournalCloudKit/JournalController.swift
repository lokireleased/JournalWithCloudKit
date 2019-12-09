//
//  JournalController.swift
//  JournalCloudKit
//
//  Created by tyson ericksen on 12/9/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import CloudKit

class JournalController {
    
    static let shared = JournalController()
    var entries: [Journal] = []
    let publicDB = CKContainer.default().publicCloudDatabase
    
    func saveEntry(with title: String, bodyText: String, completion: @escaping (Bool) -> Void) {
        let entry = Journal(title: title, bodyText: bodyText)
        let record = CKRecord(journal: entry)
        publicDB.save(record) { (record, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(false)
            }
            
            guard let record = record, let entry = Journal(ckRecord: record) else { return completion(false) }
            self.entries.insert(entry, at:0)
            completion(true)
        }
        
        
    }
    
    func addEntryWith(title: String, bodyText: String, completion: @escaping (Bool) -> Void) {
        let newEntry = Journal(title: title, bodyText: bodyText)
        entries.append(newEntry)
        saveEntry(with: title, bodyText: bodyText) { (false) in }
        
    }
    
    func fetchEntry(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.recordTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (record, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(false)
            }
            guard let record = record else { return completion(false) }
            let entry = record.compactMap {
                Journal(ckRecord: $0)
            }

            self.entries = entry
            completion(true)
        }
    }
    
}
