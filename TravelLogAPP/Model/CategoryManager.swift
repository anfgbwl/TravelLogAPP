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

    func addCategory(_ title: String) -> Category {
        if let existingCategory = getCategory(withTitle: title) {
            return existingCategory
        } else {
            let category = Category(context: context)
            category.id = UUID()
            category.title = title

            do {
                try context.save()
                return category
            } catch {
                fatalError("🚨 Failed to add category: \(error)")
            }
        }
    }

    func fetchCategory() {
        let request = Category.fetchRequest()

        do {
            categories = try context.fetch(request)
        } catch {
            print("🚨 Error: Fetch Categories")
        }
    }

    func getCategory(withTitle title: String) -> Category? {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)

        do {
            return try context.fetch(request).first
        } catch {
            print("🚨 Error fetching category: \(error)")
            return nil
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
        } catch {
            print("🚨 Error: Delete all categories")
        }
    }
}
