//
//  Univer_inf.swift
//  Omega_final_univ
//
//  Created by Даниил Игумнов on 28.06.2024.
//

import Foundation
import RealmSwift

class Univer_inf: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var country = ""
    @Persisted var name = ""
    @Persisted var rate = ""
    @Persisted var descr = ""
    @Persisted var feedback = RealmSwift.List<String>()
    @Persisted var people_rate = RealmSwift.List<String>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}
