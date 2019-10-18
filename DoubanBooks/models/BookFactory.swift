//
//  BookFactory.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class BookFactory {
    var repository: Repository<VMBook>
    private static var instance: BookFactory?
    
    
    private init(_ app: AppDelegate) {
        repository = Repository<VMBook>(app)
    }
    
    static func getInstance(_ app: AppDelegate) -> BookFactory{
        if let obj = instance {
            return obj
        }else {
            let token = "net.lzzy.factory.book"
            DispatchQueue.once(token: token, block: {
                if instance == nil {
                    instance = BookFactory(app)
                }
            })
        }
        return instance!
    }
    
    func getBookOf(category id:UUID) throws -> [VMBook] {
        return try repository.getExplicitlyBy([VMBook.colCategory], keyword: id.uuidString)
        
    }
    
    func getBookBy(id:UUID) throws -> VMBook? {
        let books = try repository.getExplicitlyBy([VMBook.colId], keyword: id.uuidString)
        if books.count>0 {
            return books[0]
        }
        return nil
    }
    
    func isBookExists(book:VMBook) throws -> Bool {
        var match10 = false
        var match13 = false
        if let isbn10 = book.isbn10 {
            if isbn10.count > 0 {
                match10 = try repository.isEntityExists([VMBook.colIsbn10], keyword: isbn10)
            }
        }
        if let isbn13 = book.isbn13 {
            if isbn13.count > 0 {
                match13 = try repository.isEntityExists([VMBook.colIsbn10], keyword: isbn13)
            }
        }
        return match10 || match13
    }
    //获取全部数据
    func getAllBook() throws -> [VMBook] {
        return try repository.getAll()
    }
    
    func add(book:VMBook)-> (Bool,String?) {
        do {
            if try repository.isEntityExists([VMBook.colIsbn10], keyword: book.isbn10!){
                return (false,"同样图书的isbn10已经存在")
            }
            if try repository.isEntityExists([VMBook.colIsbn13], keyword: book.isbn13!){
                return (false,"同样图书的isbn13已经存在")
            }
            repository.insert(vm: book)
            return (true,nil)
        } catch DataError.entityExistsError(let info) {
            return (false,info)
        } catch {
            return (false,error.localizedDescription)
        }
    }
    
    
    func deleteBook(id: UUID) -> (Bool,String?) {
        do {
            try repository.delete(id: id)
            return (true,nil)
        } catch DataError.daletEntityError(let info) {
            return (false,info)
        } catch {
            return (false,error.localizedDescription)
        }
    }
    
    func searchBooks(keyword:String) throws -> [VMBook] {
        let books = try repository.getBy([VMBook.colTitle,VMBook.colIsbn10,VMBook.colIsbn13,VMBook.colAuthor], keyword: keyword)
        return books
    }
    
    func update(book:VMBook) -> (Bool,String?) {
        do {
            try repository.update(vm: book)
            return (true,nil)
        } catch DataError.readCollestionError(let info){
            return (false,info)
        } catch {
            return (false,error.localizedDescription)
        }
    }
    
}
