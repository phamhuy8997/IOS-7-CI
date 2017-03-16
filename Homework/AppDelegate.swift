//
//  AppDelegate.swift
//  Homework
//
//  Created by Huy Pham on 2/3/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        var theBook : [[String:String]] = [
//            [
//                "name book"   : "Book 1",
//                "type"        : "novel",
//                "number"      : "10",
//                ],
//            [
//                "name Book" : "Book 2",
//                "type"        : "Humor",
//                "number"      : "15",
//                ],
//            [
//                "name Book" : "Book 3",
//                "type"        : "Ghost",
//                "number"      : "5",
//                ],
//            [
//                "name Book" : "Book 4",
//                "type"        : "Comic",
//                "number"      : "20",
//                ],
//            ]
        
//        var names = theBook.map {
//            book in
//            return book["name Book"]!
//        }
        
        
        
//        var newBook : [String:String] = [
//            "name book" : "Book 5",
//            "type"      : "so serious",
//            "number"    : "12",
//            ]
//        
//        print("Liet ke sach: ")
//        OutBook(listBook: theBook)
//        
//        //---------------------------------------
//        
//        print("Them sach: ")
//        theBook = addBook(Book: theBook, item: newBook) as! [[String:String]]
//        OutBook(listBook: theBook)
//        
//        //----------------------------------------
//        
//        print("Remove name book: ")
//        removeNameBook(listBook: theBook, nameBook: "Book 1") as! [[String : String]]
//        
//        //----------------------------------------
//        
//        print("Remove item of book: ")
//        removeNameBook(listBook: theBook, nameBook: "Book 2") as! [[String : String]]
//        OutBook(listBook: theBook)
        
        //----------------------------------------
        
        //        print("Remove book: ")
        //        theBook[2].removeValue(forKey: "name Book")
        
        //----------------------------------------
//        print("Fix item: ")
//        theBook[3] = [
//            "name Book" : "notbook",
//            "type" : "funny",
//            "number" : "12",
//        ]
//        OutBook(listBook: theBook)
        
        //-----------------------------------------
        
        return true
    }
    
//   typealias BookType = [String:String]
    
//    func updateByName(books: [BookType], name: String, newBook: BookType) -> [BookType] {
//        var localbooks = books
//        for bookIndex in 0..<localbooks.count {
//            if books["name Book"] == name {
//                localbooks[bookIndex] = newBook
//            }
//        }
//        return localbooks
//    }
    
 //   func removeNameBook(listBook: [[String:String]], nameBook: String) -> Any {
//        var book = listBook
//        let n = listBook.count
//        for i in 0..<n {
//            for (key, value) in book[i] {
//                if value == nameBook {
//                    book[i].removeAll()
//                }
//            }
//            for (key, value) in book[i] as! [String:String] {
//                print("\(key) : \(value)")
//                
//            }
//            print("-----------------")
//        }
//        return book
  //  }
    
    
//    func removeItemOfBook(listBook:[[String:String]], nameItem:String) -> Any {
//        var book = listBook
//        let n = listBook.count
//        for i in 0..<n {
//            for (key, value) in book[i] {
//                if (value == nameItem){
//                    book.remove(at: i)
//                    break
//                }
//            }
//            print("-----------------")
//        }
//        
//        return book
//    }
//    
//    func addBook(Book: [[String:Any]], item: [String:Any]) -> Array<Any> {
//        var x = Book
//        x.append(item)
//        return x
//    }
//    
//    func OutBook(listBook: [[String:Any]]) {
//        if listBook.isEmpty {
//            print("The listBook dictionary is empty!!!")
//        }
//        else {
//            let n = listBook.count
//            print("The listBook dictionary is: \n")
//            for i in 0..<n {
//                for (key,value) in listBook[i] {
//                    print("\(key)  : \(value)")
//                }
//                print("\n")
//            }
//        }
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

