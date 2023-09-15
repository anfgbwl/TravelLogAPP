//
//  BucketListViewModel.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/15.
//

import Foundation
import UIKit

class BucketListViewModel {
    private let bucketListView = BucketListView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bucketList: [Task]?
    var tableViewReloadHandler: (() -> Void)?

    func fetchBucketList() {
        let request = Task.fetchRequest()

        do {
            bucketList = try context.fetch(request)
            tableViewReloadHandler?()
        } catch {
            print("🚨 Error: Fetch Task")
        }
    }

    func addBucketListItem(_ title: String) {
        let newBucketList = Task(context: context)
        newBucketList.title = title
        newBucketList.createDate = Date()
        newBucketList.isCompleted = false

        do {
            try context.save()
            tableViewReloadHandler?()
        } catch {
            print("🚨 Error: Save Bucket List Item")
        }
    }

    func editBucketListItem(_ task: Task, _ title: String) {
        task.title = title
        task.modifyDate = Date()
        task.isCompleted = false

        do {
            try context.save()
            tableViewReloadHandler?()
        } catch {
            print("🚨 Error: Save Bucket List Item")
        }
    }

    func isCompletedBucketListItem(_ task: Task, isCompleted: Bool) {
        task.isCompleted = isCompleted

        do {
            try context.save()
            tableViewReloadHandler?()
        } catch {
            print("🚨 Error: Save Bucket List Item")
        }
    }

    func deleteBucketListItem(_ task: Task) {
        context.delete(task)

        do {
            try context.save()
            tableViewReloadHandler?()
        } catch {
            print("🚨 Error: Save task")
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
