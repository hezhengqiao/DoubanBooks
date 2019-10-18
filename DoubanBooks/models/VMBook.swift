//
//  VMBook.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class VMBook:NSObject, DataViewModelDelegate{
    
    
    
    var id : UUID
    var categoryId : UUID
    var author : String?
    var pubdate : String?
    var image : String?
    var pages : Int32?
    var isbn10 : String?
    var isbn13 : String?
    var title : String?
    var authorIntro : String?
    var price : Float?
    var summary : String?
    var publisher : String?
    
    override init(){
        id = UUID()
        categoryId = UUID()
    }
    
    static let entityName = "Book"
    static let colId = "id"
    static let colCategory = "category"
    static let colAuthor = "author"
    static let colPubdate = "pubdate"
    static let colImage = "image"
    static let colPages = "pages"
    static let colIsbn10 = "isbn10"
    static let colIsbn13 = "isbn13"
    static let colTitle = "title"
    static let colAuthorIntro = "authorIntro"
    static let colPrice = "price"
    static let colSummary = "summary"
    static let colPublisher = "publisher"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var dict:[String:Any?] = [:]
        dict[VMBook.colId] = id
        dict[VMBook.colCategory] = categoryId
        dict[VMBook.colAuthor] = author
        dict[VMBook.colPubdate] = pubdate
        dict[VMBook.colImage] = image
        dict[VMBook.colPages] = pages
        dict[VMBook.colIsbn10] = isbn10
        dict[VMBook.colIsbn13] = isbn13
        dict[VMBook.colTitle] = title
        dict[VMBook.colAuthorIntro] = authorIntro
        dict[VMBook.colSummary] = summary
        dict[VMBook.colPrice] = price
        dict[VMBook.colPublisher] = publisher
        return dict
    }
    func packageSelf(result: NSFetchRequestResult) {
        let book = result as! Book
        id = book.id!
        categoryId = book.categoryId!
        author = book.author
        pubdate = book.pubdate
        image = book.image
        pages = book.pages
        isbn10 = book.isbn10
        isbn13 = book.isbn13
        title = book.title
        authorIntro = book.authorIntro
        summary = book.summary
        price = book.price
        publisher = book.publisher
    }
   
}
