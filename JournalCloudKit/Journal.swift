//
//  Journal.swift
//  JournalCloudKit
//
//  Created by tyson ericksen on 12/9/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import CloudKit

class Journal {
    
    var title: String
    var bodyText: String
    var timeStamp: Date
//    var ckRecordID: CKRecord.ID
    
//    init(title: String, bodyText: String, timeStamp: Date = Date(), ckRecordID: CKRecord.ID(recordName: UUID().uuidString)) {
    
    init(title: String, bodyText: String, timeStamp: Date = Date()) {
    
        self.title = title
        self.bodyText = bodyText
        self.timeStamp = timeStamp
//        self.ckRecordID = ckRecordID
    }
    
}

extension Journal {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.titleKey] as? String, let bodyText = ckRecord[EntryConstants.bodyKey] as? String, let timeStamp = ckRecord[EntryConstants.timeStampKey] as? Date else { return nil }
        self.init(title: title, bodyText: bodyText, timeStamp: timeStamp)
    }
}

extension CKRecord {
    
    convenience init(journal: Journal) {
        self.init(recordType: "Journal")
        setValue(journal.title, forKey: "title")
        setValue(journal.bodyText, forKey: "body")
        setValue(journal.timeStamp, forKey: "timeStamp")
    }
}

enum EntryConstants {
    static let recordTypeKey = "Journal"
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timeStampKey = "timeStamp"
}
