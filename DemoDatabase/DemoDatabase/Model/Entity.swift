//
//  Entity.swift
//  DemoDatabase
//
//  Created by Leo Ho on 2022/11/27.
//

import Foundation
import RealmSwift

public class Entity: Object {
    
    @Persisted(primaryKey: true) public var id: ObjectId
    
    @Persisted public var title: String = ""
    
    @Persisted public var content: String = ""
}
