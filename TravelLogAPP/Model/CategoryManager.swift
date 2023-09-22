//
//  CategoryManager.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/20.
//

import CoreData
import UIKit

class CategoryManager {
    static let shared = CategoryManager()
    
    var categories: [Category]?
    let context: NSManagedObjectContext

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func fetchCategory(completion: @escaping (Bool) -> Void) {
        let request = Category.fetchRequest()

        do {
            categories = try context.fetch(request)
            completion(true)
        } catch {
            print("🚨 Error: Fetch Categories")
            completion(false)
        }
    }

    func addCategory(_ title: String) -> Category {
        if let existingCategory = getCategory(withTitle: title) {
            return existingCategory
        } else {
            let category = Category(context: context)
            category.id = UUID()
            category.title = title

            do {
                try context.save()
                fetchCategory { _ in
                    do {
                        try self.context.save()
                    } catch {
                        print("🚨 Error: Fetch Category")
                    }
                }
                return category
            } catch {
                fatalError("🚨 Failed to add category: \(error)")
            }
        }
    }

    func getCategory(withTitle title: String) -> Category? {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)

        do {
            return try context.fetch(request).first
        } catch {
            print("🚨 Error fetching category: \(error)")
            return nil
        }
    }
    
    func deleteCategory(_ category: Category) {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", category)
        
        if let tasks = category.task, tasks.count > 0 { return }
        context.delete(category)

        do {
            try context.save()
            fetchCategory { _ in
                do {
                    try self.context.save()
                } catch {
                    print("🚨 Error: Fetch Category")
                }
            }
        } catch {
            print("🚨 Error: Delete category")
        }
    }

    func deleteAllCategories() {
        let request = Category.fetchRequest()

        do {
            let categories = try context.fetch(request)
            for category in categories {
                context.delete(category)
            }
            try context.save()
            fetchCategory { _ in
                do {
                    try self.context.save()
                } catch {
                    print("🚨 Error: Fetch Category")
                }
            }
        } catch {
            print("🚨 Error: Delete all categories")
        }
    }
}
