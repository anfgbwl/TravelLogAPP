//
//  BucketListViewModel.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/15.
//

import Foundation
import UIKit

class BucketListViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bucketList: [Task]?
    var tableViewReloadHandler: (() -> Void)?

    func fetchBucketList() {
        print("fetch Task 작동")
        let request = Task.fetchRequest()

        do {
            bucketList = try context.fetch(request)
            print("ㅇㄹㅇㅇㅇㅇ")
            tableViewReloadHandler?()
        } catch {
            print("🚨 Error: Fetch Task")
        }
    }

    func addBucketListItem(_ title: String, _ taskId: String) {
        let newBucketList = Task(context: context)
        newBucketList.id = UUID(uuidString: taskId)
        newBucketList.title = title
        newBucketList.createDate = Date()
        newBucketList.isCompleted = false

        let newCategory = CategoryManager.shared.addCategory("국내")
        newCategory.addToTask(newBucketList)

        do {
            try context.save()
            fetchBucketList()
        } catch {
            print("🚨 Error: Save Bucket List Item")
        }
    }

    func editBucketListItem(_ task: Task, _ title: String, _ newCategory: Category) {
        if let oldCategory = task.category {
            oldCategory.removeFromTask(task)
            if let tasks = oldCategory.task, tasks.count == 0 {
                CategoryManager.shared.deleteCategory(oldCategory)
            }
        }

        task.title = title
        task.modifyDate = Date()
        task.isCompleted = false

        newCategory.addToTask(task)
        CategoryManager.shared.fetchCategory { _ in
            do {
                try self.context.save()
                self.fetchBucketList()
            } catch {
                print("🚨 Error: Save Bucket List Item")
            }
        }
    }

    func isCompletedBucketListItem(_ task: Task, isCompleted: Bool) {
        task.isCompleted = isCompleted

        do {
            try context.save()
            fetchBucketList()
        } catch {
            print("🚨 Error: Save Bucket List Item")
        }
    }

    func deleteBucketListItem(_ task: Task) {
        context.delete(task)

        do {
            try context.save()
            fetchBucketList()
        } catch {
            print("🚨 Error: Save task")
        }
    }

    func deleteAllTasks() {
        let request = Task.fetchRequest()

        do {
            let tasks = try context.fetch(request)
            for task in tasks {
                context.delete(task)
            }
            try context.save()
            fetchBucketList()
        } catch {
            print("🚨 Error: Delete all tasks")
        }
    }

    func formattedDate(from date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return "Empty"
        }
    }
}
