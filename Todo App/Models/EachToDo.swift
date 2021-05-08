//
//  EachItem.swift
//  Todo App
//
//  Created by Sreenivas k on 08/05/21.
//

import Foundation
import RealmSwift

class EachToDo: Object {
    @objc dynamic var title:String=""
    @objc dynamic var done:Bool=false
    
    var parentCategery = LinkingObjects(fromType:Categery.self,property: "items")
}
