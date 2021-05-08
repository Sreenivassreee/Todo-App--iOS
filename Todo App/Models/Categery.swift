//
//  Categery.swift
//  Todo App
//
//  Created by Sreenivas k on 08/05/21.
//

import Foundation
import RealmSwift

class Categery: Object {
    @objc dynamic var name:String=""
    var items=List<EachToDo>()
}
