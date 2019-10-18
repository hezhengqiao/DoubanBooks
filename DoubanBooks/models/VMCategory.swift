//
//  mvCategory.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class VMCategory:NSObject, DataViewModelDelegate {
    
    
    
    
    
    var id : UUID
    var name : String?
    var imge : String?
    
    override init() {
        id = UUID()
    }
    static let entityName = "Category"
    static let colId = "id"
    static let colName = "name"
    static let colImage = "image"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var dict:[String:Any?] = [:]
        dict[VMCategory.colId] = id
        dict[VMCategory.colName] = name
        dict[VMCategory.colImage] = imge
        
        return dict
    }
    
    func packageSelf(result: NSFetchRequestResult) {
        let category = result as! Category
        id = category.id!
        name = category.name
        imge = category.image
    }
}
