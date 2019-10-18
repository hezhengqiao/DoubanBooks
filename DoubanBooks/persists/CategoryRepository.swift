//
//  CategoryRepository.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class CategoryRepositotory{
    
    var app : AppDelegate
    var context: NSManagedObjectContext
    
    init(_ app: AppDelegate){
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func isExists(_ name:String)throws-> Bool{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:VMCategory.entityName)
        fetch.predicate = NSPredicate(format:"\(VMCategory.colName) = %@",name)
        do {
            let result = try context.fetch(fetch) as! [VMCategory]
            return result.count > 0
        } catch  {
            throw DataError.entityExistsError("判断数据失败")
        }
    }
    
    func get() throws -> [VMCategory] {
        var categoryies = [VMCategory]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:VMCategory.entityName)
        do {
            let result = try context.fetch(fetch) as! [VMCategory]
            for c in result{
                let vm = VMCategory()
                vm.id = c.id
                vm.imge = c.imge
                vm.name = c.name
                categoryies.append(vm)
            }
        } catch  {
            throw DataError.readCollestionError("读取集合数据失败")
        }
        return categoryies
        
    }
    
    func insert(vm:VMCategory) {
        let description = NSEntityDescription.entity(forEntityName: "Category", in: context)
        let category = NSManagedObject(entity: description!, insertInto: context)
        category.setValue(vm.id, forKey: "id")
        category.setValue(vm.name, forKey: "name")
        category.setValue(vm.imge, forKey: "imge")
        app.saveContext()
    }
    
    func getCategory(keyword: String? = nil) throws -> [Category] {
        var categories = [Category]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        if let kw = keyword{
            fetch.predicate = NSPredicate(format: "name like[c] %@", "*\(kw)*")
        }
        let result = try context.fetch(fetch) as! [Category]
        for item in result {
            let vm = Category()
            vm.id = item.id!
            vm.name = item.name!
            vm.image = item.image!
            categories.append(vm)
        }
        return categories
    }
    
    func delete(id: UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        let result = try context.fetch(fetch) as! [Category]
        
        for m in result{
            context.delete(m)
        }
        app.saveContext()
    }
    
}
