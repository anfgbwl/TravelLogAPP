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

    let context: NSManagedObjectContext

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }

    func addCategory(_ title: String) {
        let category = Category(context: context)
        category.id = UUID()
        category.title = title

        do {
            try context.save()
        } catch {
            print("🚨 Error adding category: \(error)")
        }
    }

    func getAllCategories() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("🚨 Error fetching categories: \(error)")
            return []
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
}
