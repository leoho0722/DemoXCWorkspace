//
//  Database.swift
//  DemoDatabase
//
//  Created by Leo Ho on 2022/11/27.
//

import Foundation
import RealmSwift

public class Database: NSObject {
    
    public static let shared = Database()
    
    
    
    // MARK: - Get Database File Path
    
    public func getDatabaseFilePath() -> String {
        let realm = try! Realm()
        
        guard let filePath = realm.configuration.fileURL?.absoluteString else {
            return ""
        }
        
        return filePath
    }
    
    // MARK: - Create ObjectId
    
    public func createObjectId() -> ObjectId {
        return ObjectId.generate()
    }
    
    // MARK: - CRUD
    
    // MARK: Create
    
    public func createData(create entity: Entity) {

        let realm = try! Realm()
        
        try! realm.write {
            realm.add(entity)
        }
    }
    
    // MARK: Read
    
    public func readData() -> [Entity] {

        let realm = try! Realm()
        
        let entityObjects = realm.objects(Entity.self)
        
        let entities: [Entity] = entityObjects.compactMap { $0 }
        
        return entities
    }
    
    // MARK: Update
    
    public func updateData(update entity: Entity) {

        let realm = try! Realm()
        
        let entityObjects = realm.objects(Entity.self).where {
            $0.id == entity.id
        }
        
        if entityObjects.count > 0 {
            try! realm.write {
                entityObjects[0].title = entity.title
                entityObjects[0].content = entity.content
            }
        }
    }
    
    // MARK: Delete
    
    public func deleteData(delete entity: Entity) {

        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(entity)
        }
    }
}
