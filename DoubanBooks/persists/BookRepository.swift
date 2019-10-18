//
//  BookRepository.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class BookRepository {
    
    var app : AppDelegate
    var context: NSManagedObjectContext
    
    init(_ app: AppDelegate){
        self.app = app
        context = app.persistentContainer.viewContext
    }
    func isExists(_ title:String)throws-> Bool{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:VMBook.entityName)
        fetch.predicate = NSPredicate(format:"\(VMBook.colTitle) = %@",title)
        do {
            let result = try context.fetch(fetch) as! [VMBook]
            return result.count > 0
        } catch  {
            throw DataError.entityExistsError("判断数据失败")
        }
    }
    //获取
    func get() throws -> [VMBook] {
        var books = [VMBook]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:VMBook.entityName)
        do {
            let result = try context.fetch(fetch) as! [VMBook]
            for c in result{
                let vm = VMBook()
                vm.id = c.id
                vm.categoryId = c.categoryId
                vm.authorIntro = c.authorIntro
                vm.author = c.author
                vm.image = c.image
                vm.isbn10 = c.isbn10
                vm.isbn13 = c.isbn13
                vm.pages = c.pages
                vm.pubdate = c.pubdate
                vm.price = c.price
                vm.summary = c.summary
                vm.title = c.title
                vm.publisher = c.publisher
                books.append(vm)
            }
        } catch  {
            throw DataError.readCollestionError("读取集合数据失败")
        }
        return books
        
    }
    
    func insert(vm:VMBook) {
        let description = NSEntityDescription.entity(forEntityName: "Book", in: context)
        let book = NSManagedObject(entity: description!, insertInto: context)
        book.setValue(vm.id, forKey: "id")
        book.setValue(vm.categoryId, forKey: "categoryId")
        book.setValue(vm.author, forKey: "author")
        book.setValue(vm.pubdate, forKey: "pubdate")
        book.setValue(vm.authorIntro, forKey: "authorIntro")
        book.setValue(vm.image, forKey: "image")
        book.setValue(vm.isbn10, forKey: "isbn10")
        book.setValue(vm.isbn13, forKey: "isbn13")
        book.setValue(vm.pages, forKey: "pages")
        book.setValue(vm.price, forKey: "price")
        book.setValue(vm.title, forKey: "title")
        book.setValue(vm.summary, forKey: "summary")
        book.setValue(vm.publisher, forKey: "publisher")
        
        app.saveContext()
    }
    //查询
    func getBook(keyword: String? = nil) throws -> [Book] {
        var books = [Book]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        if let kw = keyword{
            fetch.predicate = NSPredicate(format: "title like[c] %@", "*\(kw)*")
        }
        let result = try context.fetch(fetch) as! [Book]
        for item in result {
            let vm = Book()
            vm.id = item.id!
            vm.categoryId = item.categoryId!
            vm.image = item.image!
            vm.author = item.author!
            vm.authorIntro = item.authorIntro!
            vm.isbn10 = item.isbn10!
            vm.isbn13 = item.isbn13!
            vm.pubdate = item.pubdate!
            vm.pages = item.pages
            vm.price = item.price
            vm.title = item.title!
            vm.summary = item.summary!
            vm.publisher = item.publisher
            books.append(vm)
        }
        return books
    }
    
    func delete(id: UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        let result = try context.fetch(fetch) as! [Book]
        
        for m in result{
            context.delete(m)
        }
        app.saveContext()
    }
}

