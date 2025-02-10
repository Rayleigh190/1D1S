//
//  Photo.swift
//  1D1S
//
//  Created by 우진 on 2/8/25.
//

import Foundation
import RealmSwift

class Photo: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var fileName: String
    @Persisted var date: Date = Date()
    
    convenience init(fileName: String) {
        self.init()
        self.fileName = fileName
    }
}
