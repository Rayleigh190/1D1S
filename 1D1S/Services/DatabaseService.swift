//
//  DatabaseService.swift
//  1D1S
//
//  Created by 우진 on 2/8/25.
//

import Foundation
import RealmSwift
import RxSwift

class DatabaseService {
    static let shared = DatabaseService()
    
    private let realm = try! Realm()
    
    func save(_ object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func readAll() -> [Photo] {
        return Array(self.realm.objects(Photo.self))
    }
    
    func delete(_ object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
}
