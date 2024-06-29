//
//  Country_inf.swift
//  Omega_final_univ
//
//  Created by Даниил Игумнов on 28.06.2024.
//

import Foundation
import RealmSwift

class Country_inf: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var country = ""
    @Persisted var list_of_univ = RealmSwift.List<String>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}
